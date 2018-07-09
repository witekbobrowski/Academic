//
//  AccountNumberCoordinatorModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol AccountNumberCoordinatorModel {
    var userIsLoggedIn: Bool { get }
    var accountNumberViewController: AccountNumberViewController { get }
    func commentViewController(_ accountNumber: AccountNumber) -> CommentViewController
    func profileCoordinator(viewController: UIViewController?) -> ProfileCoordinator
    func welcomeCoordinator(viewController: UIViewController?) -> WelcomeCoordinator
}

class AccountNumberCoordinatorModelImplementation: AccountNumberCoordinatorModel {

    private let client: Client
    private let dependencyContainer: DependencyContainer

    var userIsLoggedIn: Bool { return client.authenticationService.isLoggedIn }

    var accountNumberViewController: AccountNumberViewController {
        return configuredAccountNumberViewController()
    }

    init(client: Client, dependencyContainer: DependencyContainer) {
        self.client = client
        self.dependencyContainer = dependencyContainer
    }

    func commentViewController(_ accountNumber: AccountNumber) -> CommentViewController {
        let viewController = dependencyContainer.commentViewController
        let viewModel = dependencyContainer.commentViewModel(accountNumber: accountNumber,
                                                             accountNumberService: client.accountNumberService)
        viewController.viewModel = viewModel
        return viewController
    }

    func profileCoordinator(viewController: UIViewController?) -> ProfileCoordinator {
        return dependencyContainer.profileCoordinator(client: client, viewController: viewController)
    }

    func welcomeCoordinator(viewController: UIViewController?) -> WelcomeCoordinator {
        return dependencyContainer.welcomeCoordinator(client: client, viewController: viewController)
    }

}

extension AccountNumberCoordinatorModelImplementation {

    func configuredAccountNumberViewController() -> AccountNumberViewController {
        let viewModel = dependencyContainer.accountNumberViewModel(accountNumberService: client.accountNumberService)
        let viewController = dependencyContainer.accountNumberViewController
        viewController.viewModel = viewModel
        return viewController
    }

}
