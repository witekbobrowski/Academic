//
//  AccountNumberViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 12/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol AccountNumberViewModelDelegate: class {
    func accountNumberViewModelDidRequestProfileScreen(_ accountNumberViewModel: AccountNumberViewModel)
    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel,
                                didBeginSearchingFor accountNumber: String)
    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel,
                                didFindAccountNumber accountNumber: AccountNumber)
    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel,
                                didFailSearchingWithError error: Error)
}

protocol AccountNumberViewModel {
    var delegate: AccountNumberViewModelDelegate? { get set }
    var title: String { get }
    var emptyState: String { get }
    var profileButtonAsset: String { get }
    func search(_ accountNumber: String)
    func profile()
}

class AccountNumberViewModelImplementation: AccountNumberViewModel {

    private let accountNumberService: AccountNumberService

    private var accountNumber: AccountNumber?

    weak var delegate: AccountNumberViewModelDelegate?
    var title: String { return "Forseti" }
    var emptyState: String { return "Search for account to inspect\ndetails, comments, and votes." }
    var profileButtonAsset: String { return "user_male" }

    init(accountNumberService: AccountNumberService) {
        self.accountNumberService = accountNumberService
    }

    func search(_ accountNumber: String) {
        delegate?.accountNumberViewModel(self, didBeginSearchingFor: accountNumber)
        accountNumberService.getAccountInfo(withNumber: accountNumber) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let accountNumber):
                self.accountNumber = accountNumber
                self.delegate?.accountNumberViewModel(self, didFindAccountNumber: accountNumber)
            case .failure(let error):
                self.delegate?.accountNumberViewModel(self, didFailSearchingWithError: error)
            }
        }
    }

    func profile() {
        delegate?.accountNumberViewModelDidRequestProfileScreen(self)
    }

}
