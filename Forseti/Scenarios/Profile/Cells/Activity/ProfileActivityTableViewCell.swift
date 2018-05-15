//
//  ProfileActivityTableViewCell.swift
//  Forseti
//
//  Created by Witek Bobrowski on 15/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class ProfileActivityTableViewCell: UITableViewCell {

    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    var viewModel: ProfileActivityCellViewModel? { didSet { update(with: viewModel)  } }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
}

extension ProfileActivityTableViewCell {

    private func setupView() {
        backgroundColor = .clear
        descriptionLabel.textColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
        dateLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        dateLabel.textColor = .lightGray
    }

    private func update(with viewModel: ProfileActivityCellViewModel?) {
        descriptionLabel.text = viewModel?.title
        dateLabel.text = viewModel?.date
    }

}
