//
//  ProfileTableHeaderView.swift
//  Forseti
//
//  Created by Witek Bobrowski on 15/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class ProfileTableHeaderView: UIView {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: UILabel!

    var viewModel: ProfileTableHeaderViewModel? { didSet { update(with: viewModel)  } }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

}

extension ProfileTableHeaderView {

    private func setupView() {
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
    }

    private func update(with viewModel: ProfileTableHeaderViewModel?) {
        label.text = viewModel?.name
    }

}
