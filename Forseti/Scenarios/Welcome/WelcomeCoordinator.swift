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
        viewController.viewModel.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        rootViewController = navigationController
        windowManager.setRoot(navigationController)
    }

}

extension WelcomeCoordinator: WelcomeViewModelDelegate {

    func welcomeViewModel(_ welcomeViewModel: WelcomeViewModel,
                          didRequestAuthenticationType type: AuthenticationType) {
        let viewController = coordinatorModel.authenticationViewController(type)
        viewController.viewModel.delegate = self
        (rootViewController as? UINavigationController)?.pushViewController(viewController, animated: true)
    }

}

extension WelcomeCoordinator: AuthenticationViewModelDelegate {

    func authenticationViewModel(_ authenticationViewModel: AuthenticationViewModel, didBeginAuthentication type: AuthenticationType) {
        <#code#>
    }

    func authenticationViewModel(_ authenticationViewModel: AuthenticationViewModel, didFailAuthentication type: AuthenticationType) {
        <#code#>
    }

    func authenticationViewModel(_ authenticationViewModel: AuthenticationViewModel, didSuceedAuthentication type: AuthenticationType) {
        <#code#>
    }
    
}
