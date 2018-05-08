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
}

class WelcomeCoordinatorModelImplementation: WelcomeCoordinatorModel {

    private let dependencyContainer: DependencyContainer

    var welcomeViewController: WelcomeViewController {
        return configuredWelcomeViewController()
    }

    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
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
