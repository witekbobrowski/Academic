//
//  ReviewViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 12/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol ReviewViewModelDelegate: class {
    func reviewViewModel(_ reviewViewModel: ReviewViewModel)
}

protocol ReviewViewModel {
    var delegate: ReviewViewModelDelegate? { get set }
    var upvoteButtonTitle: String { get }
    var downvoteButtonTitle: String { get }
    func upvoteAction(_ account: String)
    func downvoteAction(_ account: String)
}

class ReviewViewModelImplementation: ReviewViewModel {

    private let accountNumberService: AccountNumberService

    weak var delegate: ReviewViewModelDelegate?
    var upvoteButtonTitle: String { return "👍🏼" }
    var downvoteButtonTitle: String { return "👎🏼" }

    init(accountNumberService: AccountNumberService) {
        self.accountNumberService = accountNumberService
    }

    func upvoteAction(_ account: String) {
        print("User did upvote account " + account)
    }

    func downvoteAction(_ account: String) {
        print("User did downvote account " + account)
    }

}
