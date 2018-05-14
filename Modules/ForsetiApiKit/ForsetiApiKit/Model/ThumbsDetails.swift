//
//  ThumbsDetails.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 14/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

public struct ThumbsDetails: Codable {
    public var thumb: Thumb
    public var timeStamp: String

    public init(thumb: Thumb, timeStamp: String) {
        self.thumb = thumb
        self.timeStamp = timeStamp
    }
}
