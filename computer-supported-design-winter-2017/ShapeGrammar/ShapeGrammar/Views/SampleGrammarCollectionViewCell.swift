//
//  SampleGrammarCollectionViewCell.swift
//  ShapeGrammar
//
//  Created by Witek on 13/01/2018.
//

import UIKit

class SampleGrammarCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    private weak var shapeView: ShapeView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override func prepareForReuse() {
        shapeView.addPathForShape(nil)
        scoreLabel.text = ""
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
}

//MARK: - Public
extension SampleGrammarCollectionViewCell {
    
    public func configure(with grammar: ShapeGrammar, score: Int, isHighlighed: Bool) {
        layoutIfNeeded()
        scoreLabel.text = "Score: \(score)"
        ShapeBuildingHelper.shared.rebuildShapesInGrammar(grammar, toFitRect: shapeView.bounds)
        ShapeDrawingHelper.shared.draw(grammar, inShapeView: shapeView)
    }
    
}

//MARK: - Configuration
extension SampleGrammarCollectionViewCell {
    
    private func configure() {
        let shapeView = ShapeView()
        [self, containerView].forEach { $0.backgroundColor = .clear }
        containerView.addSubview(shapeView)
        shapeView.isOpaque = false
        shapeView.color = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        shapeView.translatesAutoresizingMaskIntoConstraints = false
        containerView.trailingAnchor.constraint(equalTo: shapeView.trailingAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: shapeView.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: shapeView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: shapeView.bottomAnchor).isActive = true
        self.shapeView = shapeView
        scoreLabel.textAlignment = .center
        scoreLabel.textColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
    }
    
}
