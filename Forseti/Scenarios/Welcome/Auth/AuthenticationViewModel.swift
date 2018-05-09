//
//  AuthenticationViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 08/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

enum AuthenticationType {
    case login
    case register
}

protocol AuthenticationViewModelDelegate: class {
    func authenticationViewModel(_ authenticationViewModel: AuthenticationViewModel,
                                 didBeginAuthentication type: AuthenticationType)
    func authenticationViewModel(_ authenticationViewModel: AuthenticationViewModel,
                                 didFailAuthentication type: AuthenticationType)
    func authenticationViewModel(_ authenticationViewModel: AuthenticationViewModel,
                                 didSuceedAuthentication type: AuthenticationType)
}

protocol AuthenticationViewModel {
    var delegate: AuthenticationViewModelDelegate? { get set }
    var type: AuthenticationType { get }
    var forgotPasswordButtonTitle: String { get }
    var continueButtonTitle: String { get }
    var emailPlaceholder: String { get }
    var passwordPlaceholder: String { get }
    func forgotPasswordAction()
    func continueAction(email: String, password: String)
}

class AuthenticationViewModelImplementation: AuthenticationViewModel {

    private let authenticationService: AuthenticationService
    let type: AuthenticationType

    weak var delegate: AuthenticationViewModelDelegate?
    var forgotPasswordButtonTitle: String { return "Forgot my password" }
    var continueButtonTitle: String { return "Continue" }
    var emailPlaceholder: String { return "Email" }
    var passwordPlaceholder: String { return "Password" }

    init(authenticationService: AuthenticationService,
         type: AuthenticationType) {
        self.authenticationService = authenticationService
        self.type = type
    }

    func forgotPasswordAction() {
        print("forgot")
    }

    func continueAction(email: String, password: String) {
        let userCredentials = UserCredentials(username: email, password: password)
        delegate?.authenticationViewModel(self, didBeginAuthentication: type)
        switch type {
        case .login:
            authenticationService.login(with: userCredentials) { [weak self] result in
                self?.handleAuthenticationCallback(result)
            }
        case .register:
            authenticationService.register(with: userCredentials) { [weak self] result in
                self?.handleAuthenticationCallback(result)
            }
        }
    }

}

extension AuthenticationViewModelImplementation {

    private func handleAuthenticationCallback<T>(_ result: Result<T>) {
        switch result {
        case .success(let result):
            delegate?.authenticationViewModel(self, didSuceedAuthentication: type)
        case .failure(let error):
            delegate?.authenticationViewModel(self, didFailAuthentication: type)
        }
    }

}
