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
    @IBOutlet private weak var statusImageView: UIImageView!
    @IBOutlet private weak var bankLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    private weak var gradientLayer: CAGradientLayer?

    var viewModel: AccountNumberDetailsCellViewModel? { didSet { update(with: viewModel)  } }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupCardView()
        setupGradientLayer()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = cardView.bounds
    }

}

extension AccountNumberDetailsTableViewCell {

    private func setupView() {
        backgroundColor = .clear
        bankLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        numberLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        locationLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        bankLabel.textColor = .white
        [numberLabel, locationLabel].forEach {
            $0?.textColor = #colorLiteral(red: 0.5894148284, green: 0.701807598, blue: 0.9098039216, alpha: 1)
            $0?.layer.shadowColor = UIColor.black.cgColor
            $0?.layer.shadowRadius = 2
        }
        locationLabel.numberOfLines = 0
        statusImageView.contentMode = .scaleAspectFit
    }

    private func setupCardView() {
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowRadius = 8
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowOpacity = 1
    }

    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.cornerRadius = 10
        gradientLayer.startPoint = CGPoint(x: 0.1, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.6, y: 0)
        gradientLayer.colors = [#colorLiteral(red: 0.7137254902, green: 0.262745098, blue: 0.7058823529, alpha: 1).cgColor, #colorLiteral(red: 0.1294117647, green: 0.4274509804, blue: 0.737254902, alpha: 1).cgColor, #colorLiteral(red: 0.0862745098, green: 0.3176470588, blue: 0.6705882353, alpha: 1).cgColor]
        gradientLayer.locations = [-0.1, 0.6, 1.1]
        cardView.layer.insertSublayer(gradientLayer, at: 0)
        self.gradientLayer = gradientLayer
    }

    private func update(with viewModel: AccountNumberDetailsCellViewModel?) {
        bankLabel.text = viewModel?.bank
        numberLabel.text = viewModel?.number
        locationLabel.text = viewModel?.location
        guard let status = viewModel?.status else {
            statusImageView.image = nil
            return
        }
        switch status {
        case .safe:
            statusImageView.image = UIImage(named: "ok")
            statusImageView.tintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case .warning:
            statusImageView.image = UIImage(named: "attention")
            statusImageView.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        case .dangerous:
            statusImageView.image = UIImage(named: "error")
            statusImageView.tintColor = #colorLiteral(red: 1, green: 0.1725490196, blue: 0.1411764706, alpha: 1)
        }
    }

}
