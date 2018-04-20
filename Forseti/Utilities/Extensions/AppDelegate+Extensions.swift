//
//  AppDelegate+Extensions.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

extension AppDelegate {

    func initialSetup() {
        let coordinatorFactory: CoordinatorFactory = DependencyContainer()
        let reviewCoordinator = coordinatorFactory.reviewCoordinator
        rootCoordinator = reviewCoordinator
        reviewCoordinator.start()
    }

}
