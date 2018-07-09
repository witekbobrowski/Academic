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

    enum Action {
        case profile
        case comment(AccountNumber)
        case thumbs
    }

    private let coordinatorModel: AccountNumberCoordinatorModel
    private let windowManager: WindowManager

    private var actionOnHold: Action?

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

    private func showWelcomeCoordinator() {
        let welcomeCoordinator = coordinatorModel.welcomeCoordinator(viewController: rootViewController)
        welcomeCoordinator.delegate = self
        next = welcomeCoordinator
        welcomeCoordinator.start()
    }

    private func perform(_ action: Action) {
        actionOnHold = nil
        switch action {
        case .profile:
            let profileCoordinator = coordinatorModel.profileCoordinator(viewController: rootViewController)
            next = profileCoordinator
            profileCoordinator.start()
        case .comment(let accountNumber):
            let viewController = coordinatorModel.commentViewController(accountNumber)
            viewController.viewModel.delegate = self
            rootViewController?.present(UINavigationController(rootViewController: viewController), animated: true)
        case .thumbs:
            break
        }
    }

}

extension AccountNumberCoordinator: AccountNumberViewModelDelegate {

    func accountNumberViewModelDidRequestProfileScreen(_ accountNumberViewModel: AccountNumberViewModel) {
        print("\(type(of: accountNumberViewModel)) did request profile screen")
        let action: Action = .profile
        guard coordinatorModel.userIsLoggedIn else {
            showWelcomeCoordinator()
            actionOnHold = action
            return
        }
        perform(action)
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

    func accountNumberViewModelCanGiveThumbs(_ accountNumberViewModel: AccountNumberViewModel) -> Bool {
        guard coordinatorModel.userIsLoggedIn else {
            showWelcomeCoordinator()
            actionOnHold = .thumbs
            return false
        }
        return true
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
        print("\(type(of: accountNumberViewModel)) did request comment screen.")
        let action: Action = .comment(accountNumber)
        guard coordinatorModel.userIsLoggedIn else {
            showWelcomeCoordinator()
            actionOnHold = action
            return
        }
        perform(action)
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

extension AccountNumberCoordinator: WelcomeCoordinatorDelegate {

    func welcomeCoordinatorDidSuceedAuthentication(_ welcomeCoordinator: WelcomeCoordinator) {
        guard let action = actionOnHold else { return }
        perform(action)
    }

    func welcomeCoordinatorDidCancelAuthentication(_ welcomeCoordinator: WelcomeCoordinator) {
        actionOnHold = nil
    }

}
