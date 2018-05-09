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
    func request<T>(_ data: [(Data, String)], method: HTTPMethod, endpoint: Endpoint, _ completion: @escaping (T) -> Void)
}

class RestClient: RestClientProtocol {

    private enum Constants {
        static let base: URL = URL(string: "http://77.55.213.42:8080/")!
    }

    func request<T>(_ data: [(Data, String)], method: HTTPMethod, endpoint: Endpoint, _ completion: @escaping (T) -> Void) {
        let headers = ["Content-Type": "multipart/form-data", "Accept": "application/json"]
        upload(multipartFormData: { multipartFormData in
                    data.forEach { multipartFormData.append($0.0, withName: $0.1) }
                },
               to: URL(string: endpoint.endpoint, relativeTo: Constants.base)!,
               method: method,
               headers: headers,
               encodingCompletion: { [weak self] result in
                    self?.handleUploadResult(result, completion)
                }
        )
    }

}

extension RestClient {

    private func handleUploadResult<T>(_ result: SessionManager.MultipartFormDataEncodingResult, _ completion: @escaping (T) -> Void) {
        //TODO: Handle callback
    }

}
