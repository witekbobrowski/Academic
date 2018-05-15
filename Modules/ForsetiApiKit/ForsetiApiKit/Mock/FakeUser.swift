//
//  FakeUser.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 15/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

let fakeUser = User(admin: false,
                    username: "witekbobrowski",
                    email: "witek@apple.com",
                    firstName: "witek",
                    lastName: "bobrowski",
                    removed: false,
                    comments: [
                        "4213481984639173553" : Comment(id: 0, comment: "String", timeStamp: "2018-05-15T21:09:31.070Z"),
                        "4213481984639173543" : Comment(id: 0, comment: "String", timeStamp: "2018-05-15T21:09:31.070Z"),
                        "4213481984639173533" : Comment(id: 0, comment: "String", timeStamp: "2018-05-15T21:09:31.070Z"),
                        "4213481984639173523" : Comment(id: 0, comment: "String", timeStamp: "2018-05-15T21:09:31.070Z"),
                        "4213481984639173513" : Comment(id: 0, comment: "String", timeStamp: "2018-05-15T21:09:31.070Z")
                    ],
                    thumbsDetails: [
                        "4213481984639173553" : ThumbsDetails(thumb: .up, timeStamp: "2018-05-15T21:09:31.070Z"),
                        "4213481984639173543" : ThumbsDetails(thumb: .up, timeStamp: "2018-05-15T21:09:31.070Z"),
                        "4213481984639173533" : ThumbsDetails(thumb: .up, timeStamp: "2018-05-15T21:09:31.070Z"),
                        "4213481984639173523" : ThumbsDetails(thumb: .up, timeStamp: "2018-05-15T21:09:31.070Z"),
                        "4213481984639173513" : ThumbsDetails(thumb: .up, timeStamp: "2018-05-15T21:09:31.070Z")
                    ])
