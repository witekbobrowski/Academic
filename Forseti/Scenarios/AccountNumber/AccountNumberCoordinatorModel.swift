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
    var accountNumberViewController: AccountNumberViewController { get }
    func profileCoordinator(viewController: UIViewController?) -> ProfileCoordinator
}

class AccountNumberCoordinatorModelImplementation: AccountNumberCoordinatorModel {

    private let client: Client
    private let dependencyContainer: DependencyContainer

    var accountNumberViewController: AccountNumberViewController {
        return configuredAccountNumberViewController()
    }

    init(client: Client, dependencyContainer: DependencyContainer) {
        self.client = client
        self.dependencyContainer = dependencyContainer
    }

    func profileCoordinator(viewController: UIViewController?) -> ProfileCoordinator {
        return dependencyContainer.profileCoordinator(client: client, viewController: viewController)
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
