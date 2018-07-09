//
//  AccountNumberActionTableViewCell.swift
//  Forseti
//
//  Created by Witek Bobrowski on 17/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class AccountNumberActionTableViewCell: UITableViewCell {

    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var upvoteButton: UIButton!
    @IBOutlet private weak var downvoteButton: UIButton!
    @IBOutlet private weak var commentButton: UIButton!
    @IBOutlet private weak var shareButton: UIButton!

    var viewModel: AccountNumberActionCellViewModel? { didSet { update(with: viewModel) } }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupButtons()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }

    @objc private func upvoteButtonDidTap(_ sender: UIButton) {
        viewModel?.thumbsUp()
        upvoteButton.tintColor = upvoteButton.tintColor == #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) ? #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1) : #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        downvoteButton.tintColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
    }
    @objc private func downvoteButtonDidTap(_ sender: UIButton) {
        viewModel?.thumbsDown()
        downvoteButton.tintColor = downvoteButton.tintColor == #colorLiteral(red: 1, green: 0.1725490196, blue: 0.1411764706, alpha: 1) ? #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1) : #colorLiteral(red: 1, green: 0.1725490196, blue: 0.1411764706, alpha: 1)
        upvoteButton.tintColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
    }
    @objc private func commentButtonDidTap(_ sender: UIButton) {
        viewModel?.comments()
    }
    @objc private func shareButtonDidTap(_ sender: UIButton) {
        viewModel?.share()
    }

}

extension AccountNumberActionTableViewCell {

    private func setupView() {
        backgroundColor = .clear
        scoreLabel.textColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }

    private func setupButtons() {
        [upvoteButton, downvoteButton].forEach { $0.setTitle(nil, for: .normal) }
        [upvoteButton, downvoteButton, commentButton, shareButton].forEach {
            $0?.tintColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
            $0?.imageView?.contentMode = .scaleAspectFit
            $0?.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        }
        [commentButton, shareButton].forEach { $0?.setTitleColor(#colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1), for: .normal) }
        upvoteButton.addTarget(self, action: #selector(upvoteButtonDidTap(_:)), for: .touchUpInside)
        downvoteButton.addTarget(self, action: #selector(downvoteButtonDidTap(_:)), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(commentButtonDidTap(_:)), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonDidTap(_:)), for: .touchUpInside)
    }

    private func update(with viewModel: AccountNumberActionCellViewModel?) {
        scoreLabel.text = "\(viewModel?.score ?? 0)"
        commentButton.setTitle(viewModel?.commentsButtonTitle, for: .normal)
        shareButton.setTitle(viewModel?.shareButtonTitle, for: .normal)
        guard let viewModel = viewModel else { return }
        upvoteButton.setImage(UIImage(named: viewModel.thumbsUpButtonAsset), for: .normal)
        downvoteButton.setImage(UIImage(named: viewModel.thumbsDownButtonAsset), for: .normal)
        commentButton.setImage(UIImage(named: viewModel.commentsButtonAsset), for: .normal)
        shareButton.setImage(UIImage(named: viewModel.shareButtonAsset), for: .normal)
    }
}
