//
//  CoordinatorFactory.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol CoordinatorFactory {
    var reviewCoordinator: ReviewCoordinator { get }
    func welcomeCoordinator(client: Client) -> WelcomeCoordinator
}

extension DependencyContainer: CoordinatorFactory {

    var reviewCoordinator: ReviewCoordinator {
        return ReviewCoordinator(coordinatorModel: reviewCoordinatorModel,
                                 windowManager: windowManager)
    }

    func welcomeCoordinator(client: Client) -> WelcomeCoordinator {
        return WelcomeCoordinator(coordinatorModel: welcomeCoordinatorModel(client: client),
                                  windowManager: windowManager)
    }

}
