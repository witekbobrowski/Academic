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
    var emailPlaceholder: String { get }
    var passwordPlaceholder: String { get }
}

class AuthenticationViewModelImplementation: AuthenticationViewModel {
    var emailPlaceholder: String { return "Email" }
    var passwordPlaceholder: String { return "Password" }
}
