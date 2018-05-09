//
//  Client.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 09/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public protocol Client {
    var authenticationService: Any { get }
    var userService: Any { get }
    var accountService: Any { get }
}

class ForsetiClient: Client {

    private let restClient: Any
    private let dependencyContainer: Any

    init(restClient: Any,
         dependencyContainer: Any) {
        self.restClient = restClient
        self.dependencyContainer = dependencyContainer
    }

    var authenticationService: Any { return dependencyContainer }
    var userService: Any { return dependencyContainer }
    var accountService: Any { return dependencyContainer }

}
