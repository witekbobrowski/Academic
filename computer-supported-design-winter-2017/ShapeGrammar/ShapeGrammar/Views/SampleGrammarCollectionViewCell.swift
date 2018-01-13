//
//  SampleGrammarCollectionViewCell.swift
//  ShapeGrammar
//
//  Created by Witek on 13/01/2018.
//

import UIKit

class SampleGrammarCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var scoreLabel: UILabel!
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

    override func layoutSubviews() {
        super.layoutSubviews()
        shapeView.frame = bounds
    }
    
}

//MARK: - Public
extension SampleGrammarCollectionViewCell {
    
    public func configure(with Grammar: Grammar<Shape>, score: Int, isHighlighed: Bool) {
        scoreLabel.text = "Score: \(score)"
        layer.borderColor = isHighlighed ? UIColor.green.cgColor : UIColor.lightGray.cgColor
    }
    
}

//MARK: - Configuration
extension SampleGrammarCollectionViewCell {
    
    private func configure() {
        backgroundColor = .clear
        layer.cornerRadius = 16
        layer.borderWidth = 2
        let shapeView = ShapeView(frame: bounds)
        insertSubview(shapeView, at: 0)
        self.shapeView = shapeView
    }
    
}
