//
//  AccountNumberService.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 17/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public protocol AccountNumberService {
    func getAccountInfo(withNumber number: String, completion: @escaping CompletionHandler<String>)
}
