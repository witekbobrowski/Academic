//
//  SampleGrammarCollectionSectionHeaderView.swift
//  ShapeGrammar
//
//  Created by Witek on 16/01/2018.
//

import UIKit

class SampleGrammarCollectionSectionHeaderView: UICollectionReusableView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
}

//MARK: - Configuration
extension SampleGrammarCollectionSectionHeaderView {
    
    private func configure() {
        backgroundColor = .clear
        [titleLabel, detailLabel].forEach { label in
            label?.textAlignment = .right
            label?.textColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        }
    }
    
    public func configure(withTitle title: String?, disclosure: String?) {
        titleLabel.text = title
        detailLabel.text = disclosure
    }
    
}
