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
    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel,
                                didBeginSendingThumb thumb: Thumb,
                                forAccountNumber accountNumber: String)
    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel,
                                didSendThumb thumb: Thumb,
                                forAccountNumber accountNumber: AccountNumber)
    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel,
                                didFailToSendThumb thumb: Thumb,
                                withError error: Error)
}

protocol AccountNumberViewModel {
    var delegate: AccountNumberViewModelDelegate? { get set }
    var title: String { get }
    var emptyState: String { get }
    var profileButtonAsset: String { get }
    var numberOfSections: Int { get }
    func numberOfRows(inSection section: Int) -> Int
    func search(_ accountNumber: String)
    func profile()
    func detailsCellViewModel() -> AccountNumberDetailsCellViewModel
    func actionsCellViewModel() -> AccountNumberActionCellViewModel
}

extension Notification.Name {
    static var accountNumberViewModelDidFindAccount: Notification.Name {
        return Notification.Name(rawValue: "AccountNumberViewModel.accountNumberViewModelDidFindAccount")
    }
}

class AccountNumberViewModelImplementation: AccountNumberViewModel {

    private let accountNumberService: AccountNumberService
    private let dependencyContainer: DependencyContainer

    private let sections: [AccountNumberViewController.Section] = [.details, .actions]
    private var accountNumber: AccountNumber?

    weak var delegate: AccountNumberViewModelDelegate?
    var title: String { return "Forseti" }
    var emptyState: String { return "Search for account to inspect\ndetails, comments, and votes." }
    var profileButtonAsset: String { return "user_male" }
    var numberOfSections: Int { return accountNumber == nil ? 0 : sections.count }

    init(accountNumberService: AccountNumberService,
         dependencyContainer: DependencyContainer) {
        self.accountNumberService = accountNumberService
        self.dependencyContainer = dependencyContainer
    }

    func numberOfRows(inSection section: Int) -> Int {
        guard let section = AccountNumberViewController.Section(rawValue: section) else { return 0 }
        switch section {
        case .details: return 1
        case .actions: return 1
        }
    }

    func search(_ accountNumber: String) {
        delegate?.accountNumberViewModel(self, didBeginSearchingFor: accountNumber)
        accountNumberService.getAccountInfo(withNumber: accountNumber) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let accountNumber):
                self.accountNumber = accountNumber
                NotificationCenter.default.post(name: .accountNumberViewModelDidFindAccount, object: accountNumber)
                self.delegate?.accountNumberViewModel(self, didFindAccountNumber: accountNumber)
            case .failure(let error):
                self.delegate?.accountNumberViewModel(self, didFailSearchingWithError: error)
            }
        }
    }

    func profile() {
        delegate?.accountNumberViewModelDidRequestProfileScreen(self)
    }

    func detailsCellViewModel() -> AccountNumberDetailsCellViewModel {
        return dependencyContainer.accountNumberDetailsCellViewModel(accountNumber: accountNumber!)
    }

    func actionsCellViewModel() -> AccountNumberActionCellViewModel {
        var viewModel = dependencyContainer.accountNumberActionCellViewModel(accountNumber: accountNumber!)
        viewModel.delegate = self
        return viewModel
    }
}

extension AccountNumberViewModelImplementation: AccountNumberActionCellViewModelDelegate {

    func accountNumberActionCellViewModel(_ accountNumberActionCellViewModel: AccountNumberActionCellViewModel,
                                          didRequestAction action: AccountNumberAction) {
        switch action {
        case .thumbsUp:
            thumb(.up)
        case .thumbsDown:
            thumb(.down)
        case .comments:
            break
        case .share:
            break
        }
    }

}

extension AccountNumberViewModelImplementation {

    private func thumb(_ thumb: Thumb) {
        guard let number = accountNumber?.accountNumber else { return }
        delegate?.accountNumberViewModel(self, didBeginSendingThumb: thumb, forAccountNumber: number)
        accountNumberService.thumb(thumb, accountNumber: number) { result in
            switch result {
            case .success(let accountNumber):
                self.accountNumber = accountNumber
                NotificationCenter.default.post(name: .accountNumberViewModelDidFindAccount, object: accountNumber)
                self.delegate?.accountNumberViewModel(self, didSendThumb: thumb, forAccountNumber: accountNumber)
            case .failure(let error):
                self.delegate?.accountNumberViewModel(self, didFailToSendThumb: thumb, withError: error)
            }
        }
    }

}
