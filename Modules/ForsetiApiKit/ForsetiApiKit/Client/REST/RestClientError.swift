//
//  RestClientError.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 13/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public enum RestClientError: Error {
    case invalidStatusCode(Int?)
    case invalidResultValue
    case failedToDecodeJSON
}
