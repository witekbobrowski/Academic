//
//  AccountNumberDetailsCellViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 17/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol AccountNumberDetailsCellViewModel {
    var number: String { get }
}

class AccountNumberDetailsCellViewModelImplementation: AccountNumberDetailsCellViewModel {

    private let accountNumber: AccountNumber

    var number: String { return accountNumber.accountNumber }

    init(accountNumber: AccountNumber) {
        self.accountNumber = accountNumber
    }

}
