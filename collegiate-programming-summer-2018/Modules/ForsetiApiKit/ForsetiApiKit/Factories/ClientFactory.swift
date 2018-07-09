//
//  ClientFactory.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 09/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import Alamofire

protocol ClientFactory {
    var restClient: RestClientProtocol { get }
    var client: Client { get }
}

extension DependencyContainer: ClientFactory {

    private var baseURL: URL { return URL(string: "http://77.55.213.42:8080/")! }

    var restClient: RestClientProtocol {
        return RestClient(baseURL: baseURL)
    }

    var client: Client {
        return ForsetiClient(restClient: restClient, dependencyContainer: self)
    }

}
