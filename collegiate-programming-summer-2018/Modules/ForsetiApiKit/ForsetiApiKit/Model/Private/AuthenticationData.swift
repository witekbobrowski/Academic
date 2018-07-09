//
//  AuthenticationData.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 13/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

struct AuthenticationData: Codable {
    var token: String
    var username: String

    enum CodingKeys: String, CodingKey {
        case token = "Authorization", username
    }

}
