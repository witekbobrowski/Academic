//
//  ProfileAvatarTableViewCell.swift
//  Forseti
//
//  Created by Witek Bobrowski on 15/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class ProfileAvatarTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var label: UILabel!

    var viewModel: ProfileAvatarCellViewModel? { didSet { update(with: viewModel)  } }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

}

extension ProfileAvatarTableViewCell {

    private func setupView() {
        backgroundColor = .clear
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
    }

    private func update(with viewModel: ProfileAvatarCellViewModel?) {
        label.text = viewModel?.name
    }

}
