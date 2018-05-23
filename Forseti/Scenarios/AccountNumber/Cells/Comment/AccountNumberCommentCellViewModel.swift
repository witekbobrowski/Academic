//
//  AccountNumberCommentCellViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 21/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol AccountNumberCommentCellViewModel {
    var username: String { get }
    var date: String { get }
    var content: String { get }
}

class AccountNumberCommentCellViewModelImplementation: AccountNumberCommentCellViewModel {

    private let comment: Comment

    let username: String
    var date: String { return DateFormatter.forsetiFormatter.string(from: comment.date ?? Date()) }
    var content: String { return comment.comment }

    init(comment: Comment, username: String) {
        self.comment = comment
        self.username = username
    }

}
