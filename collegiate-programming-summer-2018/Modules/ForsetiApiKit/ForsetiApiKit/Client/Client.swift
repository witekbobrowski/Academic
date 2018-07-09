//
//  Client.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 09/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public protocol Client {
    var authenticationService: AuthenticationService { get }
    var accountNumberService: AccountNumberService { get }
    var userService: UserService { get }
}

class ForsetiClient: Client {

    private let restClient: RestClientProtocol
    private let dependencyContainer: DependencyContainer

    init(restClient: RestClientProtocol,
         dependencyContainer: DependencyContainer) {
        self.restClient = restClient
        self.dependencyContainer = dependencyContainer
    }

    var authenticationService: AuthenticationService {
        return dependencyContainer.authenticationService(restClient: restClient)
    }
    var accountNumberService: AccountNumberService {
        return dependencyContainer.accountNumberService(restClient: restClient)
    }
    var userService: UserService {
        return dependencyContainer.userService(restClient: restClient)
    }

}
