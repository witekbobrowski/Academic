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
    @IBOutlet private weak var exitButton: UIBarButtonItem!

    var viewModel: WelcomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @objc private func loginButtonDidTap(_ sender: UIButton) {
        viewModel.login()
    }

    @objc private func registerButtonDidTap(_ sender: UIButton) {
        viewModel.register()
    }

    @objc private func exitButtonDidTap(_ sender: UIButton) {
        viewModel.exit()
    }

}

extension WelcomeViewController {

    private func setupView() {
        titleLabel.text = viewModel.title
        titleLabel.textColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
        exitButton.action = #selector(exitButtonDidTap(_:))
        exitButton.target = self
        loginButton.setTitle(viewModel.loginButtonTitle, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonDidTap(_:)), for: .touchUpInside)
        loginButton.setTitleColor(#colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1), for: .normal)
        registerButton.setTitle(viewModel.registerButtonTitle, for: .normal)
        registerButton.addTarget(self, action: #selector(registerButtonDidTap(_:)), for: .touchUpInside)
        registerButton.layer.cornerRadius = 8
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
