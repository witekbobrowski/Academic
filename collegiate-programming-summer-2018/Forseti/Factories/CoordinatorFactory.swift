//
//  CoordinatorFactory.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit
import ForsetiApiKit

protocol CoordinatorFactory {
    func accountNumberCoordinator(client: Client) -> AccountNumberCoordinator
    func welcomeCoordinator(client: Client, viewController: UIViewController?) -> WelcomeCoordinator
    func profileCoordinator(client: Client, viewController: UIViewController?) -> ProfileCoordinator
}

extension DependencyContainer: CoordinatorFactory {

    func accountNumberCoordinator(client: Client) -> AccountNumberCoordinator {
        return AccountNumberCoordinator(coordinatorModel: accountNumberCoordinatorModel(client: client),
                                        windowManager: windowManager)
    }

    func welcomeCoordinator(client: Client, viewController: UIViewController?) -> WelcomeCoordinator {
        return WelcomeCoordinator(coordinatorModel: welcomeCoordinatorModel(client: client),
                                  windowManager: windowManager,
                                  viewController: viewController)
    }

    func profileCoordinator(client: Client, viewController: UIViewController?) -> ProfileCoordinator {
        return ProfileCoordinator(coordinatorModel: profileCoordinatorModel(client: client),
                                  viewControler: viewController)
    }

}
