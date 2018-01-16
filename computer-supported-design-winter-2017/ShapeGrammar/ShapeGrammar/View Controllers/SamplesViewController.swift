//
//  SamplesViewController.swift
//  ShapeGrammar
//
//  Created by Witek on 13/01/2018.
//

import UIKit

protocol SamplesViewControllerDelegate: AnyObject {
    func samplesViewController(_ samplesViewController: SamplesViewController, didPickGrammarsToCross grammars: [(grammar: ShapeGrammar, score: Int)])
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
    
    private var model: [Section] = []  { didSet { collectionView.reloadData() } }
    private var selected: [IndexPath] = []
    
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
        guard !selected.isEmpty else { return }
        let selectedItems = selected.map { self.model[$0.section].items[$0.row] }
        selected = []
        insertGeneration(ofItems: selectedItems)
        updateButton(forEnabled: !selected.isEmpty)
    }
    
}

//MARK: - Public
extension SamplesViewController {
    
    public func insertGeneration(ofItems items: [Item]) {
        let section = Section(title: "Generation \(model.count)", items: items)
        model.insert(section, at: 0)
    }
    
    public func clear() {
        
    }
    
}

//MARK: - Configuration
extension SamplesViewController {
    
    private func configure() {
        [view, collectionView].forEach { $0?.backgroundColor = .clear }
        titleLabel.textColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        crossButton.setTitle("Cross selected", for: .normal)
        crossButton.addTarget(self, action: #selector(crossButtonDidTap(_:)), for: .touchUpInside)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        let bundle = Bundle(for: type(of: self))
        collectionView.register(UINib(nibName: String(describing: SampleGrammarCollectionViewCell.self), bundle: bundle), forCellWithReuseIdentifier: String(describing: SampleGrammarCollectionViewCell.self))
    }
    
    private func updateButton(forEnabled enabled: Bool) {
        crossButton.isEnabled = enabled
        crossButton.setTitleColor(enabled ? UIColor(red: 0, green: 122/255, blue: 1, alpha: 1) : .lightGray, for: .normal)
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SamplesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = selected.index(of: indexPath) {
            selected.remove(at: index)
        } else {
            selected.append(indexPath)
        }
        updateButton(forEnabled: !selected.isEmpty)
        collectionView.reloadItems(at: [indexPath])
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
        cell.configure(with: item.grammar, title: "Score: \(item.score)", isHighlighed: selected.contains(indexPath))
        return cell
    }
    
}
