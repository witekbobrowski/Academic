//
//  Result.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 09/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
