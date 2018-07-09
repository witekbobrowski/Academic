//
//  AccountNumberCommentTableViewCell.swift
//  Forseti
//
//  Created by Witek Bobrowski on 21/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class AccountNumberCommentTableViewCell: UITableViewCell {

    @IBOutlet private weak var userLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!

    var viewModel: AccountNumberCommentCellViewModel? { didSet { update(with: viewModel) } }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

}

extension AccountNumberCommentTableViewCell {

    private func setupView() {
        backgroundColor = .clear
        [userLabel, dateLabel].forEach { label in
            label?.textColor = .lightGray
            label?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        }
        contentLabel.numberOfLines = 0
        contentLabel.textColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
        contentLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }

    private func update(with viewModel: AccountNumberCommentCellViewModel?) {
        userLabel.text = viewModel?.username
        dateLabel.text = viewModel?.date
        contentLabel.text = viewModel?.content
    }

}
