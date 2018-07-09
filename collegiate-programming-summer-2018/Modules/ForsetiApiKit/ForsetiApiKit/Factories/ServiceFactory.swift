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
    func accountNumberService(restClient: RestClientProtocol) -> AccountNumberService
    func userService(restClient: RestClientProtocol) -> UserService
}

extension DependencyContainer: ServiceFactory {

    func authenticationService(restClient: RestClientProtocol) -> AuthenticationService {
        return AuthenticationServiceImplementation(restClient: restClient)
    }

    func userService(restClient: RestClientProtocol) -> UserService {
        return UserServiceImplementation(restClient: restClient)
    }

    func accountNumberService(restClient: RestClientProtocol) -> AccountNumberService {
        let path = Bundle(for: type(of: self)).url(forResource: "number_details_processed", withExtension: "csv")!
        let numberDetailsProvider = NumberDetailsProviderImplementation(pathToNumberDetailsFile: path)
        return AccountNumberServiceImplementation(restClient: restClient,
                                                  numberDetailsProvider: numberDetailsProvider)
    }

}
