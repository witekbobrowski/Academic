//
//  SamplesViewController.swift
//  ShapeGrammar
//
//  Created by Witek on 13/01/2018.
//

import UIKit

class SamplesViewController: UIViewController {

    public typealias Item = (grammar: Grammar<Shape>, score: Int)
    
    private enum Constants {
        static let visibleItems: CGFloat = 2
        static let spacing: CGFloat = 16
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    public var items: [Item] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

//MARK: - Configuration
extension SamplesViewController {
    
    private func configure() {
        [view, collectionView].forEach { $0?.backgroundColor = .clear }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        let bundle = Bundle(for: type(of: self))
        collectionView.register(UINib(nibName: String(describing: SampleGrammarCollectionViewCell.self), bundle: bundle), forCellWithReuseIdentifier: String(describing: SampleGrammarCollectionViewCell.self))
    }
    
}

//MARK: - UICollectionViewDelegate
extension SamplesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - (Constants.spacing * (Constants.visibleItems + 1))) / Constants.visibleItems
        return CGSize(width: width, height: collectionView.bounds.height - Constants.spacing * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
    }
    
}

//MARK: - UICollectionViewDataSource
extension SamplesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SampleGrammarCollectionViewCell.self), for: indexPath) as! SampleGrammarCollectionViewCell
        let item = items[indexPath.row]
        cell.configure(with: item.grammar, score: item.score, isHighlighed: false)
        return cell
    }
    
}
