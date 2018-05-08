//
//  WelcomeViewController.swift
//  Forseti
//
//  Created by Witek Bobrowski on 08/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!

    var viewModel: WelcomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @objc private func loginButtonDidTap(_ sender: UIButton) {
        viewModel.login()
    }

    @objc private func registerButtonDidTap(_ sender: UIButton) {
        viewModel.register()
    }

}

extension WelcomeViewController {

    private func setupView() {
        titleLabel.text = viewModel.title
        loginButton.setTitle(viewModel.loginButtonTitle, for: .normal)
        registerButton.setTitle(viewModel.registerButtonTitle, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonDidTap(_:)), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonDidTap(_:)), for: .touchUpInside)
        registerButton.layer.cornerRadius = 8
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = .blue
    }

}
