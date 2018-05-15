//
//  ProfileOptionTableViewCell.swift
//  Forseti
//
//  Created by Witek Bobrowski on 15/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class ProfileOptionTableViewCell: UITableViewCell {

    @IBOutlet private weak var label: UILabel!

    var viewModel: ProfileOptionCellViewModel? { didSet { update(with: viewModel)  } }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

}

extension ProfileOptionTableViewCell {

    private func setupView() {
        backgroundColor = .clear
        label.textColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
    }

    private func update(with viewModel: ProfileOptionCellViewModel?) {
        label.text = viewModel?.title
    }

}
