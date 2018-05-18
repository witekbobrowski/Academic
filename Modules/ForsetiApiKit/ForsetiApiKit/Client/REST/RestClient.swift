//
//  RestClient.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 09/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import Alamofire

protocol RestClientProtocol {
    func request<T: Codable>(_ data: Data?,
                             method: HTTPMethod,
                             endpoint: Endpoint,
                             completion: @escaping CompletionHandler<T>)
    func query<T: Codable>(_ parameters: Parameters?,
                           method: HTTPMethod,
                           endpoint: Endpoint,
                           completion: @escaping CompletionHandler<T>)
    func authenticate(with authenticationData: AuthenticationData)
    func logout()
}

class RestClient: RestClientProtocol {

    private var manager: SessionManager
    private let base: URL

    init() {
        self.manager = SessionManager(configuration: .default)
        self.base = URL(string: "http://127.0.0.1:8080/")!
    }

    func request<T: Codable>(_ data: Data?,
                             method: HTTPMethod,
                             endpoint: Endpoint,
                             completion: @escaping CompletionHandler<T>) {
        var request = URLRequest(url: base.appendingPathComponent(endpoint.path))
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        manager.request(request).responseJSON { [weak self] response in
            self?.handleRequestResponse(response, completion: completion)
        }
    }

    func query<T: Codable>(_ parameters: Parameters?,
                           method: HTTPMethod,
                           endpoint: Endpoint,
                           completion: @escaping CompletionHandler<T>) {
        var request = URLRequest(url: base.appendingPathComponent(endpoint.path))
        let encoding = URLEncoding.queryString
        guard let encoded = try? encoding.encode(request, with: parameters) else {
            completion(.failure(RestClientError.failedToEncodeParameters))
            return
        }
        request = encoded
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.request(request).responseJSON { [weak self] response in
            self?.handleRequestResponse(response, completion: completion)
        }

    }

    func authenticate(with authenticationData: AuthenticationData) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            AuthenticationData.CodingKeys.token.rawValue: authenticationData.token]
        manager = SessionManager(configuration: configuration)
    }

    func logout() {
        manager = SessionManager(configuration: .default)
    }

}

extension RestClient {

    private func handleRequestResponse<T: Codable>(_ response: DataResponse<Any>,
                                                   completion: @escaping CompletionHandler<T>) {
        guard let statusCode = response.response?.statusCode, statusCode == 200 else {
            completion(.failure(RestClientError.invalidStatusCode(response.response?.statusCode)))
            return
        }
        switch response.result {
        case .success(let value):
            guard let data = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted) else {
                completion(.failure(RestClientError.invalidResultValue))
                return
            }
            guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(RestClientError.failedToDecodeJSON))
                return
            }
            completion(.success(decoded))
        case .failure(let error):
            completion(.failure(error))
        }
    }

}
