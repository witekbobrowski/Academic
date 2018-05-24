//
//  AccountNumberCoordinator.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit
import ForsetiApiKit
import SVProgressHUD

class AccountNumberCoordinator: Coordinator {

    private let coordinatorModel: AccountNumberCoordinatorModel
    private let windowManager: WindowManager

    var next: Coordinator?
    weak var rootViewController: UIViewController?

    init(coordinatorModel: AccountNumberCoordinatorModel,
         windowManager: WindowManager) {
        self.coordinatorModel = coordinatorModel
        self.windowManager = windowManager
    }

    func start() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let viewController = coordinatorModel.accountNumberViewController
        viewController.viewModel.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        rootViewController = navigationController
        windowManager.setRoot(navigationController)
        appDelegate.rootCoordinator = self
        appDelegate.window = windowManager.window
    }

}

extension AccountNumberCoordinator: AccountNumberViewModelDelegate {

    func accountNumberViewModelDidRequestProfileScreen(_ accountNumberViewModel: AccountNumberViewModel) {
        let profileCoordinator = coordinatorModel.profileCoordinator(viewController: rootViewController)
        print("\(type(of: accountNumberViewModel)) did request \(type(of: profileCoordinator))")
        next = profileCoordinator
        profileCoordinator.start()
    }

    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel,
                                didBeginSearchingFor accountNumber: String) {
        print("\(type(of: accountNumberViewModel)) did begin searching for account with number: \(accountNumber)")
    }

    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel,
                                didFindAccountNumber accountNumber: AccountNumber) {
        print("\(type(of: accountNumberViewModel)) did find account with number: \(accountNumber.accountNumber)")
    }

    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel,
                                didFailSearchingWithError error: Error) {
        print("\(type(of: accountNumberViewModel)) did fail searching with error: \(error)")
    }

    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel,
                                didBeginSendingThumb thumb: Thumb,
                                forAccountNumber accountNumber: String) {
        print("\(type(of: accountNumberViewModel)) did begin sending thumb \(thumb) for account with number: \(accountNumber)")
    }

    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel,
                                didSendThumb thumb: Thumb,
                                forAccountNumber accountNumber: AccountNumber) {
        print("\(type(of: accountNumberViewModel)) did send thumb \(thumb) for account with number: \(accountNumber.accountNumber)")
    }

    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel,
                                didFailToSendThumb thumb: Thumb,
                                withError error: Error) {
        print("\(type(of: accountNumberViewModel)) did fail to send thumb \(thumb) with error: \(error)")
    }

    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel,
                                didRequestCommentScreenForAccount accountNumber: AccountNumber) {
        let viewController = coordinatorModel.commentViewController(accountNumber)
        viewController.viewModel.delegate = self
        rootViewController?.present(UINavigationController(rootViewController: viewController), animated: true)
    }

}

extension AccountNumberCoordinator: CommentViewModelDelegate {

    func commentViewModelDidRequestExit(_ commentViewModel: CommentViewModel) {
        print("\(type(of: commentViewModel)) did request exit!")
        rootViewController?.presentedViewController?.dismiss(animated: true)
    }

    func commentViewModel(_ commentViewModel: CommentViewModel, didBeginSending comment: String) {
        print("\(type(of: commentViewModel)) did begin sending comment")
        SVProgressHUD.show()
    }

    func commentViewModel(_ commentViewModel: CommentViewModel, didSuccesfulySend comment: String) {
        print("\(type(of: commentViewModel)) did send comment: \(comment)")
        SVProgressHUD.showSuccess(withStatus: nil)
        SVProgressHUD.dismiss(withDelay: 0.5) { [weak self] in
            self?.rootViewController?.presentedViewController?.dismiss(animated: true)
        }
    }

    func commentViewModel(_ commentViewModel: CommentViewModel, didFailToSend comment: String, with error: Error) {
        print("\(type(of: commentViewModel)) did fail fetching with error: \(error)")
        SVProgressHUD.showError(withStatus: nil)
        SVProgressHUD.dismiss(withDelay: 0.5)
    }

}
