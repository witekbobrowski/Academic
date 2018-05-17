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
    func reviewViewModel(_ reviewViewModel: ReviewViewModel, didBeginSearchingFor accountNumber: String)
    func reviewViewModel(_ reviewViewModel: ReviewViewModel, didFindAccountNumber accountNumber: AccountNumber)
    func reviewViewModel(_ reviewViewModel: ReviewViewModel, didFailSearchingWithError error: Error)
}

protocol ReviewViewModel {
    var delegate: ReviewViewModelDelegate? { get set }
    var title: String { get }
    func search(_ accountNumber: String)
}

class ReviewViewModelImplementation: ReviewViewModel {

    private let accountNumberService: AccountNumberService

    private var accountNumber: AccountNumber?

    weak var delegate: ReviewViewModelDelegate?
    var title: String { return "Forseti" }

    init(accountNumberService: AccountNumberService) {
        self.accountNumberService = accountNumberService
    }

    func search(_ accountNumber: String) {
        delegate?.reviewViewModel(self, didBeginSearchingFor: accountNumber)
        accountNumberService.getAccountInfo(withNumber: accountNumber) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let accountNumber):
                self.accountNumber = accountNumber
                self.delegate?.reviewViewModel(self, didFindAccountNumber: accountNumber)
            case .failure(let error):
                self.delegate?.reviewViewModel(self, didFailSearchingWithError: error)
            }
        }
    }

}
