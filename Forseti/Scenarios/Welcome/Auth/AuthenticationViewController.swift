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
    @IBOutlet private weak var upperSeparatorView: UIView!
    @IBOutlet private weak var bottomsSeparatorView: UIView!

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
        [upperSeparatorView, bottomsSeparatorView].forEach { $0?.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1).withAlphaComponent(0.5) }
        emailTextField.placeholder = viewModel.emailPlaceholder
        passwordTextField.placeholder = viewModel.passwordPlaceholder
        [emailTextField, passwordTextField].forEach { textField in
            textField?.borderStyle = .none
            textField?.textColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
        }
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
