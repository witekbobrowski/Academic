//
//  CommentActivityCellViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 15/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

class CommentActivityCellViewModel: ProfileActivityCellViewModel {

    private let comment: Comment
    private let accountNumber: String

    var title: String { return "✍🏽 You have commented on account with number: \(accountNumber)." }
    var date: String { return DateFormatter.forsetiFormatter.string(from: comment.date ?? Date()) }

    init(comment: Comment, accountNumber: String) {
        self.comment = comment
        self.accountNumber = accountNumber
    }

    func action() {
        print("Clicked cell with \(comment)")
    }

}
