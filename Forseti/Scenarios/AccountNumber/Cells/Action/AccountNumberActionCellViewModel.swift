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
}

class AccountNumberActionCellViewModelImplementation: AccountNumberActionCellViewModel {

    private let accountNumber: AccountNumber

    var score: Int { return accountNumber.thumbsUp - accountNumber.thumbsDown }
    var thumbsUpButtonAsset: String { return "" }
    var thumbsDownButtonAsset: String { return "" }

    init(accountNumber: AccountNumber) {
        self.accountNumber = accountNumber
    }

}
