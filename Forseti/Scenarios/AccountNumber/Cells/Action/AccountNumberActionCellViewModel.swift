//
//  AccountNumberActionCellViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 17/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol AccountNumberActionCellViewModel {
    var score: Int { get }
    var thumbsUpButtonAsset: String { get }
    var thumbsDownButtonAsset: String { get }
    var commentsButtonAsset: String { get }
    var shareButtonAsset: String { get }
    var commentsButtonTitle: String { get }
    var shareButtonTitle: String { get }

    func thumbsUp()
    func thumbsDown()
    func comments()
    func share()
}

class AccountNumberActionCellViewModelImplementation: AccountNumberActionCellViewModel {

    private let accountNumber: AccountNumber

    var score: Int { return accountNumber.thumbsUp - accountNumber.thumbsDown }
    var thumbsUpButtonAsset: String { return "thumbs_up" }
    var thumbsDownButtonAsset: String { return "thumbs_down" }
    var commentsButtonAsset: String { return "comments" }
    var shareButtonAsset: String { return "paper_plane" }
    var commentsButtonTitle: String { return "\(accountNumber.comments.count)" }
    var shareButtonTitle: String { return "Share" }

    init(accountNumber: AccountNumber) {
        self.accountNumber = accountNumber
    }

    func thumbsUp() {}
    func thumbsDown() {}
    func comments() {}
    func share() {}
}
