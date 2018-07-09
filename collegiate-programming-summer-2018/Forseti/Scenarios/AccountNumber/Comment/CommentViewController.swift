//
//  CommentViewController.swift
//  Forseti
//
//  Created by Witek Bobrowski on 21/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var exitButton: UIBarButtonItem!
    @IBOutlet private weak var sendButton: UIBarButtonItem!

    var viewModel: CommentViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }

    @objc private func exitButtonDidTap(_ sender: UIBarButtonItem) {
        viewModel.exit()
    }

    @objc private func sendButtonDidTap(_ sender: UIBarButtonItem) {
        viewModel.comment(textView.text)
    }

}

extension CommentViewController {

    private func setupView() {
        sendButton.title = viewModel.sendButtonTitle
        sendButton.action = #selector(sendButtonDidTap(_:))
        exitButton.action = #selector(exitButtonDidTap(_:))
        [sendButton, exitButton].forEach { $0?.target = self }
        titleLabel.text = viewModel.title
        titleLabel.textColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        separatorView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textView.textColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
        textView.toolbarPlaceholder = viewModel.textFieldPlaceholder
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

}
