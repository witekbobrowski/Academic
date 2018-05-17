//
//  WelcomeCoordinatorModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 08/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol WelcomeCoordinatorModel {
    var welcomeViewController: WelcomeViewController { get }
    func authenticationViewController(_ type: AuthenticationType) -> AuthenticationViewController
    func profileCoordinator(viewController: UIViewController?) -> ProfileCoordinator
}

class WelcomeCoordinatorModelImplementation: WelcomeCoordinatorModel {

    private let dependencyContainer: DependencyContainer
    private let client: Client

    var welcomeViewController: WelcomeViewController {
        return configuredWelcomeViewController()
    }

    init(client: Client,
         dependencyContainer: DependencyContainer) {
        self.client = client
        self.dependencyContainer = dependencyContainer
    }

    func authenticationViewController(_ type: AuthenticationType) -> AuthenticationViewController {
        let viewModel = dependencyContainer.authenticationViewModel(authenticationService: client.authenticationService, type: type)
        let viewController = dependencyContainer.authenticationViewController
        viewController.viewModel = viewModel
        return viewController
    }

    func profileCoordinator(viewController: UIViewController?) -> ProfileCoordinator {
        return dependencyContainer.profileCoordinator(client: client, viewController: viewController)
    }
}

extension WelcomeCoordinatorModelImplementation {

    func configuredWelcomeViewController() -> WelcomeViewController {
        let viewModel = dependencyContainer.welcomeViewModel
        let viewController = dependencyContainer.welcomeViewController
        viewController.viewModel = viewModel
        return viewController
    }

}
