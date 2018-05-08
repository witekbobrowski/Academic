//
//  WelcomeCoordinatorModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 08/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol WelcomeCoordinatorModel {
    var welcomeViewController: WelcomeViewController { get }
    func authenticationViewController(_ type: AuthenticationType) -> AuthenticationViewController
}

class WelcomeCoordinatorModelImplementation: WelcomeCoordinatorModel {

    private let dependencyContainer: DependencyContainer

    var welcomeViewController: WelcomeViewController {
        return configuredWelcomeViewController()
    }

    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
    }

    func authenticationViewController(_ type: AuthenticationType) -> AuthenticationViewController {
        let viewModel = dependencyContainer.authenticationViewModel(type)
        let viewController = dependencyContainer.authenticationViewController
        viewController.viewModel = viewModel
        return viewController
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
