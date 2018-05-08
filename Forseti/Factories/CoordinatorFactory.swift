//
//  CoordinatorFactory.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol CoordinatorFactory {
    var reviewCoordinator: ReviewCoordinator { get }
    var welcomeCoordinator: WelcomeCoordinator { get }
}

extension DependencyContainer: CoordinatorFactory {

    var reviewCoordinator: ReviewCoordinator {
        return ReviewCoordinator(coordinatorModel: reviewCoordinatorModel,
                                 windowManager: windowManager)
    }

    var welcomeCoordinator: WelcomeCoordinator {
        return WelcomeCoordinator(coordinatorModel: welcomeCoordinatorModel,
                                  windowManager: windowManager)
    }

}
