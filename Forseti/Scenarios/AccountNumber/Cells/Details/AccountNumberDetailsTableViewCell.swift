//
//  AccountNumberDetailsTableViewCell.swift
//  Forseti
//
//  Created by Witek Bobrowski on 17/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class AccountNumberDetailsTableViewCell: UITableViewCell {

    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var bankLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!

    var viewModel: AccountNumberDetailsCellViewModel? { didSet { update(with: viewModel)  } }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupCardView()
    }

}

extension AccountNumberDetailsTableViewCell {

    private func setupView() {
        backgroundColor = .clear

    }

    private func setupCardView() {
        cardView.layer.cornerRadius = 8
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowRadius = 4
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowOpacity = 0.5
        cardView.backgroundColor = .lightGray
    }

    private func update(with viewModel: AccountNumberDetailsCellViewModel?) {
        bankLabel.text = viewModel?.bank
        numberLabel.text = viewModel?.number
        locationLabel.text = viewModel?.location
    }

}
