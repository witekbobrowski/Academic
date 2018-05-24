//
//  AuthenticationService.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 09/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public protocol AuthenticationService {
    var isLoggedIn: Bool { get }
    func login(with userCredentials: UserCredentials, completion: @escaping CompletionHandler<String>)
    func register(with userCredentials: UserCredentials, completion: @escaping CompletionHandler<String>)
    func logout()
}

class AuthenticationServiceImplementation: AuthenticationService {

    private enum AuthenticationEndpoint: String, Endpoint {
        case login = "login"
        case register = "signup/"

        var path: String { return self.rawValue }
    }

    private let restClient: RestClientProtocol

    private (set) var isLoggedIn: Bool = false

    init(restClient: RestClientProtocol) {
        self.restClient = restClient
    }

    func login(with userCredentials: UserCredentials, completion: @escaping CompletionHandler<String>) {
        guard let data = try? JSONEncoder().encode(userCredentials) else { return }
        restClient.request(data,
                           method: .post,
                           endpoint: AuthenticationEndpoint.login) { [unowned self] (result: Result<AuthenticationData>) in
            switch result {
            case .success(let authData):
                self.isLoggedIn = true
                self.restClient.authenticate(with: authData)
                completion(.success(authData.username))
            case .failure(let error):
                self.isLoggedIn = false
                completion(.failure(error))
            }
        }
    }

    func register(with userCredentials: UserCredentials, completion: @escaping CompletionHandler<String>) {
        guard let data = try? JSONEncoder().encode(userCredentials) else { return }
        restClient.request(data,
                           method: .post,
                           endpoint: AuthenticationEndpoint.register) { [unowned self] (result: Result<EmptyResponse>) in
            switch result {
            case .success:
                self.login(with: userCredentials, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func logout() {
        restClient.logout()
        isLoggedIn = false
    }

}
