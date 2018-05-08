//
//  WelcomeViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 08/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol WelcomeViewModel {
    var title: String { get }
    var loginButtonTitle: String { get }
    var registerButtonTitle: String { get }

    func login()
    func register()
}

class WelcomeViewModelImplementation: WelcomeViewModel {

    var title: String { return "Forseti" }
    var loginButtonTitle: String { return "Login with email" }
    var registerButtonTitle: String { return "Register" }

    func login() {}

    func register() {}

}
