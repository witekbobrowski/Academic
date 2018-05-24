//
//  AppDelegate+Extensions.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit
import ForsetiApiKit

extension AppDelegate {

    func initialSetup() {
        let coordinatorFactory: CoordinatorFactory = DependencyContainer()
        let client = ForsetiApiKit.client
        let welcomeCoordinator = coordinatorFactory.welcomeCoordinator(client: client)
        welcomeCoordinator.start()
    }

}
