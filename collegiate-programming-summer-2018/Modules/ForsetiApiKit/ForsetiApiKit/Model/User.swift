//
//  User.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 14/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public struct User: Codable {
    var admin: Bool
    var removed: Bool
    public var username: String
    public var email: String?
    public var firstName: String?
    public var lastName: String?
    public var comments: [String: [Comment]]
    public var thumbsDetails: [String: ThumbsDetails]
}
