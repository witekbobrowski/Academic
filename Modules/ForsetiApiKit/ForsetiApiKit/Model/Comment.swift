//
//  Comment.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 10/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public struct Comment {

    public var comment: String
    public var timeStamp: String

    public init(comment: String, timeStamp: String) {
        self.comment = comment
        self.timeStamp = timeStamp
    }

}
