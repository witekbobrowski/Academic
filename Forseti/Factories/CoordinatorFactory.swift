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
    func welcomeCoordinator(client: Client) -> WelcomeCoordinator
    func reviewCoordinator(client: Client) -> ReviewCoordinator
    func profileCoordinator(client: Client, viewController: UIViewController?) -> ProfileCoordinator
}

extension DependencyContainer: CoordinatorFactory {

    func welcomeCoordinator(client: Client) -> WelcomeCoordinator {
        return WelcomeCoordinator(coordinatorModel: welcomeCoordinatorModel(client: client),
                                  windowManager: windowManager)
    }

    func reviewCoordinator(client: Client) -> ReviewCoordinator {
        return ReviewCoordinator(coordinatorModel: reviewCoordinatorModel(client: client),
                                 windowManager: windowManager)
    }

    func profileCoordinator(client: Client, viewController: UIViewController?) -> ProfileCoordinator {
        return ProfileCoordinator(coordinatorModel: profileCoordinatorModel(client: client),
                                  viewControler: viewController)
    }

}
