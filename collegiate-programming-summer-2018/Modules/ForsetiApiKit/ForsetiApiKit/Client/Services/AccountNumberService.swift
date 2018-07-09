//
//  AccountNumberService.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 17/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public protocol AccountNumberService {
    func getDetails(of accountNumber: AccountNumber) -> NumberDetails?
    func getAccountInfo(withNumber number: String, completion: @escaping CompletionHandler<AccountNumber>)
    func thumb(_ thumb: Thumb, accountNumber: String, completion: @escaping CompletionHandler<AccountNumber>)
    func comment(_ comment: String, accountNumber: String, completion: @escaping CompletionHandler<AccountNumber>)
}

class AccountNumberServiceImplementation: AccountNumberService {

    private enum AccountNumberEndpoint: Endpoint {
        case accountNumber(String)
        case thumb(String)
        case comment(String)

        var path: String {
            switch self {
            case .accountNumber(let number): return "api/accountNumber/\(number)"
            case .thumb(let number): return "api/accountNumber/thumb/\(number)"
            case .comment(let number): return "api/accountNumber/comment/\(number)"
            }
        }
    }

    private let restClient: RestClientProtocol
    private let numberDetailsProvider: NumberDetailsProvider

    init(restClient: RestClientProtocol, numberDetailsProvider: NumberDetailsProvider) {
        self.restClient = restClient
        self.numberDetailsProvider = numberDetailsProvider
    }

    func getDetails(of accountNumber: AccountNumber) -> NumberDetails? {
        return numberDetailsProvider.numberDetails(forAccountNumber: accountNumber)
    }

    func getAccountInfo(withNumber number: String, completion: @escaping (Result<AccountNumber>) -> Void) {
        restClient.request(nil,
                           method: .get,
                           endpoint: AccountNumberEndpoint.accountNumber(number),
                           completion: completion)
    }

    func thumb(_ thumb: Thumb, accountNumber: String, completion: @escaping CompletionHandler<AccountNumber>) {
        restClient.query(["thumb": thumb.rawValue],
                         method: .put,
                         endpoint: AccountNumberEndpoint.thumb(accountNumber),
                         completion: completion)
    }

    func comment(_ comment: String, accountNumber: String, completion: @escaping (Result<AccountNumber>) -> Void) {
        restClient.request(comment.data(using: .utf8),
                           method: .put,
                           endpoint: AccountNumberEndpoint.comment(accountNumber),
                           completion: completion)
    }

}
