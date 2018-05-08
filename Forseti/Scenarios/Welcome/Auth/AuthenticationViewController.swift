//
//  AuthenticationViewController.swift
//  Forseti
//
//  Created by Witek Bobrowski on 08/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var continueButton: UIButton!

    var viewModel: AuthenticationViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @objc private func forgotPasswordButtonDidTap(_ sender: UIButton) {
        viewModel.forgotPasswordAction()
    }

    @objc private func continueButtonDidTap(_ sender: UIButton) {
        viewModel.continueAction()
    }

}

extension AuthenticationViewController {

    private func setupView() {
        emailTextField.placeholder = viewModel.emailPlaceholder
        passwordTextField.placeholder = viewModel.passwordPlaceholder
        [emailTextField, passwordTextField].forEach { $0?.borderStyle = .none }
        forgotPasswordButton.setTitle(viewModel.forgotPasswordButtonTitle, for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonDidTap(_:)), for: .touchUpInside)
        forgotPasswordButton.setTitleColor(#colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1), for: .normal)
        forgotPasswordButton.isHidden = viewModel.type == .register
        continueButton.setTitle(viewModel.continueButtonTitle, for: .normal)
        continueButton.addTarget(self, action: #selector(continueButtonDidTap(_:)), for: .touchUpInside)
        continueButton.layer.cornerRadius = 8
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
    }

}
