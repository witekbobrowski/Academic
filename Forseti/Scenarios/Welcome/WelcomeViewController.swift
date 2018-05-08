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
        titleLabel.textColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
        loginButton.setTitle(viewModel.loginButtonTitle, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonDidTap(_:)), for: .touchUpInside)
        loginButton.setTitleColor(#colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1), for: .normal)
        registerButton.setTitle(viewModel.registerButtonTitle, for: .normal)
        registerButton.addTarget(self, action: #selector(registerButtonDidTap(_:)), for: .touchUpInside)
        registerButton.layer.cornerRadius = 8
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
    }

}
