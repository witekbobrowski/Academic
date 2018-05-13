//
//  WelcomeViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 08/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol WelcomeViewModelDelegate: class {
    func welcomeViewModel(_ welcomeViewModel: WelcomeViewModel, didRequestAuthenticationType type: AuthenticationType)
}

protocol WelcomeViewModel {
    var delegate: WelcomeViewModelDelegate? { get set }
    var title: String { get }
    var loginButtonTitle: String { get }
    var registerButtonTitle: String { get }

    func login()
    func register()
}

class WelcomeViewModelImplementation: WelcomeViewModel {

    weak var delegate: WelcomeViewModelDelegate?
    var title: String { return "Forseti" }
    var loginButtonTitle: String { return "Login" }
    var registerButtonTitle: String { return "Register" }

    func login() {
        delegate?.welcomeViewModel(self, didRequestAuthenticationType: .login)
    }

    func register() {
        delegate?.welcomeViewModel(self, didRequestAuthenticationType: .register)
    }

}
