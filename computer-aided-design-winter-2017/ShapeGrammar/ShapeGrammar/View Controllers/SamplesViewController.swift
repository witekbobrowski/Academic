//
//  SamplesViewController.swift
//  ShapeGrammar
//
//  Created by Witek on 13/01/2018.
//

import UIKit

protocol SamplesViewControllerDelegate: AnyObject {
    func samplesViewController(_ samplesViewController: SamplesViewController, didPickGrammarsToCrossbreed grammars: [(grammar: ShapeGrammar, score: Int)])
}

class SamplesViewController: UIViewController {

    public typealias Item = (grammar: ShapeGrammar, score: Int)
    
    private enum Constants {
        static let visibleItems: CGFloat = 3
        static let spacing: CGFloat = 16
    }
    
    private struct Section {
        var title: String
        var items: [Item]
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var crossButton: UIButton!
    
    private var model: [Section] = [] { didSet { collectionView.reloadData() } }
    
    public var delegate: SamplesViewControllerDelegate?
    
    override var title: String? {
        didSet {
            super.title = title
            titleLabel.text = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        updateButton(forEnabled: false)
    }

    @objc private func crossButtonDidTap(_ sender: UIButton) {
        guard let currentGeneration = model.first?.items, !currentGeneration.isEmpty else { return }
        delegate?.samplesViewController(self, didPickGrammarsToCrossbreed: currentGeneration)
    }
    
}

//MARK: - Public
extension SamplesViewController {
    
    public var currentGeneration: [ShapeGrammar] {
        return model.first?.items.map { $0.grammar } ?? []
    }
    
    public func insertGeneration(ofItems items: [Item]) {
        updateButton(forEnabled: true)
        let section = Section(title: "Generation \(model.count)", items: items.sorted { $0.score > $1.score})
        model.insert(section, at: 0)
    }
    
    public func clear() {
        updateButton(forEnabled: false)
        model = []
    }
    
}

//MARK: - Configuration
extension SamplesViewController {
    
    private func configure() {
        [view, collectionView].forEach { $0?.backgroundColor = .clear }
        titleLabel.textColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        crossButton.setTitle("Cross generation", for: .normal)
        crossButton.addTarget(self, action: #selector(crossButtonDidTap(_:)), for: .touchUpInside)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        let bundle = Bundle(for: type(of: self))
        collectionView.register(UINib(nibName: String(describing: SampleGrammarCollectionViewCell.self), bundle: bundle), forCellWithReuseIdentifier: String(describing: SampleGrammarCollectionViewCell.self))
        collectionView.register(UINib(nibName: String(describing: SampleGrammarCollectionSectionHeaderView.self), bundle: bundle), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: SampleGrammarCollectionSectionHeaderView.self))
    }
    
    private func updateButton(forEnabled enabled: Bool) {
        crossButton.isEnabled = enabled
        crossButton.setTitleColor(enabled ? UIColor(red: 0, green: 122/255, blue: 1, alpha: 1) : .lightGray, for: .normal)
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SamplesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width/3, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: SampleGrammarCollectionSectionHeaderView.self), for: indexPath)
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SamplesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - (Constants.spacing * (Constants.visibleItems + 1 ))) / Constants.visibleItems
        return CGSize(width: width, height: collectionView.bounds.height - Constants.spacing * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
    }
    
}

//MARK: - UICollectionViewDataSource
extension SamplesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SampleGrammarCollectionViewCell.self), for: indexPath) as! SampleGrammarCollectionViewCell
        let item = model[indexPath.section].items[indexPath.row]
        cell.configure(with: item.grammar, title: "Score: \(item.score)", isHighlighed: false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard let headerView = view as? SampleGrammarCollectionSectionHeaderView else { return }
        let secion = model[indexPath.section]
        headerView.configure(withTitle: secion.title, disclosure: "Population: \(secion.items.count)")
    }
    
}
