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
    private let numberDetails: NumberDetails?

    var bank: String? { return numberDetails?.bankName }
    var number: String { return accountNumber.accountNumber }
    var location: String? { return locationDescription(numberDetails) }
    var status: AccountNumberStatus { return .safe }

    init(accountNumber: AccountNumber, numberDetails: NumberDetails?) {
        self.accountNumber = accountNumber
        self.numberDetails = numberDetails
    }

    private func locationDescription(_ numberDetails: NumberDetails?) -> String? {
        guard let details = numberDetails else { return nil }
        var description: String = ""
        description += details.outpost + ", "
        description += details.address + ", "
        description += details.postal
        return description
    }

}
