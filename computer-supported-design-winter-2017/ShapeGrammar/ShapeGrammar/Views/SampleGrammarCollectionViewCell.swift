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
        let shapeView = ShapeView()
        shapeView.frame = containerView.bounds
        [self, containerView].forEach { $0.backgroundColor = .clear }
        containerView.addSubview(shapeView)
        shapeView.isOpaque = false
        shapeView.color = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        self.shapeView = shapeView
        scoreLabel.textAlignment = .center
        scoreLabel.textColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
    }
    
}
