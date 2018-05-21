//
//  CommentViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 21/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol CommentViewModelDelegate: class {
    func commentViewModelDidRequestExit(_ commentViewModel: CommentViewModel)
    func commentViewModel(_ commentViewModel: CommentViewModel, didBeginSending comment: String)
    func commentViewModel(_ commentViewModel: CommentViewModel, didSuccesfulySend comment: String)
    func commentViewModel(_ commentViewModel: CommentViewModel, didFailToSend comment: String, with error: Error)
}

protocol CommentViewModel {
    var delegate: CommentViewModelDelegate? { get set }
    var title: String { get }
    var textFieldPlaceholder: String { get }
    var sendButtonTitle: String { get }
    func comment(_ contents: String?)
    func exit()
}

class CommentViewModelImplementation: CommentViewModel {

    private let accountNumber: AccountNumber
    private let accountNumberService: AccountNumberService

    weak var delegate: CommentViewModelDelegate?

    var title: String { return accountNumber.accountNumber }
    var textFieldPlaceholder: String { return "Comment" }
    var sendButtonTitle: String { return "Send" }

    init(accountNumber: AccountNumber, accountNumberService: AccountNumberService) {
        self.accountNumber = accountNumber
        self.accountNumberService = accountNumberService
    }

    func comment(_ contents: String?) {
        guard let comment = contents else { return }
        delegate?.commentViewModel(self, didBeginSending: comment)
        accountNumberService.comment(comment, accountNumber: accountNumber.accountNumber) { result in
            switch result {
            case .success:
                self.delegate?.commentViewModel(self, didSuccesfulySend: comment)
            case .failure(let error):
                self.delegate?.commentViewModel(self, didFailToSend: comment, with: error)
            }
        }
    }

    func exit() {
        delegate?.commentViewModelDidRequestExit(self)
    }

}
