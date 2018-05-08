//
//  AuthenticationViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 08/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

enum AuthenticationType {
    case login
    case register
}

protocol AuthenticationViewModel {
    var type: AuthenticationType { get }
    var forgotPasswordButtonTitle: String { get }
    var continueButtonTitle: String { get }
    var emailPlaceholder: String { get }
    var passwordPlaceholder: String { get }
    func forgotPasswordAction()
    func continueAction()
}

class AuthenticationViewModelImplementation: AuthenticationViewModel {

    let type: AuthenticationType

    var forgotPasswordButtonTitle: String { return "Forgot my password" }
    var continueButtonTitle: String { return "Continue" }
    var emailPlaceholder: String { return "Email" }
    var passwordPlaceholder: String { return "Password" }

    init(type: AuthenticationType) {
        self.type = type
    }

    func forgotPasswordAction() {
        print("forgot")
    }

    func continueAction() {
        print("continue")
    }

}
