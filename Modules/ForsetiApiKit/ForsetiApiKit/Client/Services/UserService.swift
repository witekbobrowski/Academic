//
//  UserService.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 14/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public protocol UserService {
    func getUser(completion: @escaping CompletionHandler<User>)
}

class UserServiceImplementation: UserService {

    private let restClient: RestClientProtocol

    init(restClient: RestClientProtocol) {
        self.restClient = restClient
    }

    func getUser(completion: @escaping (Result<User>) -> Void) {
        completion(.success(fakeUser))
//        restClient.request(nil, method: .get, endpoint: UserEndpoint.user, completion: completion)
    }

}
