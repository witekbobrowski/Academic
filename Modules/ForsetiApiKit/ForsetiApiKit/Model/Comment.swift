//
//  Comment.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 10/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public struct Comment: Codable {
    public var id: Int
    public var comment: String
    public var timeStamp: String
}
