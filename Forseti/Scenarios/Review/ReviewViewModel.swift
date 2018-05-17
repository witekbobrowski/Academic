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
}

class ReviewViewModelImplementation: ReviewViewModel {

    private let accountNumberService: AccountNumberService

    weak var delegate: ReviewViewModelDelegate?

    init(accountNumberService: AccountNumberService) {
        self.accountNumberService = accountNumberService
    }

}
