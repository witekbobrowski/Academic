//
//  ServiceFactory.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 09/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol ServiceFactory {
    func authenticationService(restClient: RestClientProtocol) -> AuthenticationService
    func userService(restClient: RestClientProtocol) -> UserService
}

extension DependencyContainer: ServiceFactory {

    func authenticationService(restClient: RestClientProtocol) -> AuthenticationService {
        return AuthenticationServiceImplementation(restClient: restClient)
    }

    func userService(restClient: RestClientProtocol) -> UserService {
        return UserServiceImplementation(restClient: restClient)
    }

}
