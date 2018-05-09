//
//  ClientFactory.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 09/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol ClientFactory {
    var restClient: RestClientProtocol { get }
    var client: Client { get }
}

extension DependencyContainer: ClientFactory {

    var restClient: RestClientProtocol { return RestClient() }

    var client: Client {
        return ForsetiClient(restClient: restClient, dependencyContainer: self)
    }

}
