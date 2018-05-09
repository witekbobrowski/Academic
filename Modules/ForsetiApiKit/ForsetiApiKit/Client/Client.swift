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
}

class ForsetiClient: Client {

    private let restClient: RestClient
    private let dependencyContainer: DependencyContainer

    init(restClient: RestClient,
         dependencyContainer: DependencyContainer) {
        self.restClient = restClient
        self.dependencyContainer = dependencyContainer
    }

    var authenticationService: AuthenticationService {
        return dependencyContainer.authenticationService(restClient: restClient)
    }

}
