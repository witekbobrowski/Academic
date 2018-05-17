//
//  AccountNumberCoordinator.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit
import ForsetiApiKit

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
        let viewController = coordinatorModel.accountNumberViewController
        viewController.viewModel.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        rootViewController = navigationController
        windowManager.setRoot(navigationController)
        (UIApplication.shared.delegate as? AppDelegate)?.window = windowManager.window
    }

}

extension AccountNumberCoordinator: AccountNumberViewModelDelegate {

    func accountNumberViewModelDidRequestProfileScreen(_ accountNumberViewModel: AccountNumberViewModel) {
        let profileCoordinator = coordinatorModel.profileCoordinator(viewController: rootViewController)
        print("\(type(of: accountNumberViewModel)) did request \(type(of: profileCoordinator))")
        next = profileCoordinator
        profileCoordinator.start()
    }

    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel, didBeginSearchingFor accountNumber: String) {
        print("\(type(of: accountNumberViewModel)) did begin searching for account with number: \(accountNumber)")
    }

    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel, didFindAccountNumber accountNumber: AccountNumber) {
        print("\(type(of: accountNumberViewModel)) did find account with number: \(accountNumber.accountNumber)")
    }

    func accountNumberViewModel(_ accountNumberViewModel: AccountNumberViewModel, didFailSearchingWithError error: Error) {
        print("\(type(of: accountNumberViewModel)) did fail searching with error: \(error)")
    }

}
