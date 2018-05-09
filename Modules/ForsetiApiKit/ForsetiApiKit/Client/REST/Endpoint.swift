//
//  Endpoint.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 09/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol Endpoint {
    var endpoint: String { get }
}

enum AuthenticationEndpoint: Endpoint {
    case login
    case register

    var endpoint: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "signup"
        }
    }
}
