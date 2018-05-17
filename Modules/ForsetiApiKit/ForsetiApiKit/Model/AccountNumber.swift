//
//  AccountNumber.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 17/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public struct AccountNumber: Codable {
    public var accountNumber: String
    public var comments: [String: Comment]
    public var removedUsersComments: [String: Comment]
    public var thumbsDetails: [String: ThumbsDetails]
    public var thumbsDown: Int
    public var thumbsUp: Int
}
