//
//  UserService.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 14/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public protocol UserService {
    func getUser(completion: @escaping CompletionHandler<User>)
}
