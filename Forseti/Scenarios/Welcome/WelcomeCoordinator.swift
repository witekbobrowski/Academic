//
//  WelcomeCoordinator.swift
//  Forseti
//
//  Created by Witek Bobrowski on 08/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class WelcomeCoordinator: Coordinator {

    private let coordinatorModel: WelcomeCoordinatorModel
    private let windowManager: WindowManager

    var next: Coordinator?
    weak var rootViewController: UIViewController?

    init(coordinatorModel: WelcomeCoordinatorModel,
         windowManager: WindowManager) {
        self.coordinatorModel = coordinatorModel
        self.windowManager = windowManager
    }

    func start() {
        let viewController = coordinatorModel.welcomeViewController
        rootViewController = viewController
        windowManager.setRoot(viewController)
    }

}

extension WelcomeCoordinator: WelcomeViewModelDelegate {

    func welcomeViewModel(_ welcomeViewModel: WelcomeViewModel,
                          didRequestAuthenticationType type: AuthenticationType) {

    }

}
