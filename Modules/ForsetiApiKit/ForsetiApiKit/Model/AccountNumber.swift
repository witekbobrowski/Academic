//
//  AccountNumber.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 17/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public struct AccountNumber: Codable {
    let accountNumber: String
    let comments: [String: Comment]
    let removedUsersComments: [String: Comment]
    let thumbsDetails: [String: ThumbsDetails]
    let thumbsDown: Int
    let thumbsUp: Int
}
