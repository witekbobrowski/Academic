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
}

class RestClient: RestClientProtocol {

    private let manager: SessionManager = SessionManager(configuration: .default)
    private let base: URL = URL(string: "https://d97fd0fd.ngrok.io/")!

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

}

extension RestClient {

    private func handleRequestResponse<T: Codable>(_ response: DataResponse<Any>,
                                                   completion: @escaping CompletionHandler<T>) {
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
