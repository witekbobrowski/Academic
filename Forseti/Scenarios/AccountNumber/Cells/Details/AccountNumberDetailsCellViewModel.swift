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
    var bank: String? { get }
    var number: String { get }
    var location: String? { get }
    var status: AccountNumberStatus { get }
}

enum AccountNumberStatus {
    case safe
    case warning
    case dangerous
}

class AccountNumberDetailsCellViewModelImplementation: AccountNumberDetailsCellViewModel {

    private let accountNumber: AccountNumber

    var bank: String? { return "Barclays Bank" }
    var number: String { return accountNumber.accountNumber }
    var location: String? { return "High Street, Bognor Regis PO211, UK" }
    var status: AccountNumberStatus { return .safe }

    init(accountNumber: AccountNumber) {
        self.accountNumber = accountNumber
    }

}
