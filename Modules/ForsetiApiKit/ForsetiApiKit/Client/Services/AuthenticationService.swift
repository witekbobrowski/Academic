//
//  AuthenticationService.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 09/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public protocol AuthenticationService {
    func login(with userCredentials: UserCredentials, completion: @escaping CompletionHandler<String>)
    func register(with userCredentials: UserCredentials, completion: @escaping CompletionHandler<String>)
    func logout()
}

class AuthenticationServiceImplementation: AuthenticationService {

    private let restClient: RestClientProtocol

    init(restClient: RestClientProtocol) {
        self.restClient = restClient
    }

    func login(with userCredentials: UserCredentials, completion: @escaping CompletionHandler<String>) {
        restClient.request([],
                           method: .post,
                           endpoint: AuthenticationEndpoint.login,
                           completion: completion)
    }

    func register(with userCredentials: UserCredentials, completion: @escaping CompletionHandler<String>) {
        restClient.request([],
                           method: .post,
                           endpoint: AuthenticationEndpoint.register,
                           completion: completion)
    }

    func logout() {
        // TODO: Enable establishing unsecured connection
    }

}
