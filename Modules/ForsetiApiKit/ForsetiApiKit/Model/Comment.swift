//
//  Comment.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 10/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public struct Comment {

    public var id: Int
    public var comment: String
    public var timeStamp: String

    public init(id: Int, comment: String, timeStamp: String) {
        self.id = id
        self.comment = comment
        self.timeStamp = timeStamp
    }

}
