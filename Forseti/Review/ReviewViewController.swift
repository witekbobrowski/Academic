//
//  ReviewViewController.swift
//  Forseti
//
//  Created by Witek Bobrowski on 12/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet private weak var accountTextField: UITextField!
    @IBOutlet private weak var upvoteButton: UIButton!
    @IBOutlet private weak var downvoteButton: UIButton!

    var viewModel: ReviewViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @objc private func upvoteButtonDidTap(_ sender: UIButton) {
        guard let account = accountTextField.text else { return }
        viewModel.upvoteAction(account)
    }

    @objc private func downvoteButtonDidTap(_ sender: UIButton) {
        guard let account = accountTextField.text else { return }
        viewModel.downvoteAction(account)
    }

}

extension ReviewViewController {

    private func setupView() {
        upvoteButton.setTitle(viewModel.upvoteButtonTitle, for: .normal)
        downvoteButton.setTitle(viewModel.downvoteButtonTitle, for: .normal)
    }

}
