//
//  AccountNumberService.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 17/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public protocol AccountNumberService {
    func getAccountInfo(withNumber number: String, completion: @escaping CompletionHandler<AccountNumber>)
}

class AccountNumberServiceImplementation: AccountNumberService {

    private enum AccountNumberEndpoint: String, Endpoint {
        case accountNumber = "api/accountNumber/"

        var path: String { return self.rawValue }
    }

    private let restClient: RestClientProtocol

    init(restClient: RestClientProtocol) {
        self.restClient = restClient
    }

    func getAccountInfo(withNumber number: String, completion: @escaping (Result<AccountNumber>) -> Void) {
        guard let data = try? JSONEncoder().encode(["number": number]) else { return }
        restClient.request(data,
                           method: .get,
                           endpoint: AccountNumberEndpoint.accountNumber,
                           completion: completion)
    }

}
