//
//  WelcomeCoordinator.swift
//  Forseti
//
//  Created by Witek Bobrowski on 08/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol WelcomeCoordinatorDelegate: class {
    func welcomeCoordinatorDidSuceedAuthentication(_ welcomeCoordinator: WelcomeCoordinator)
}

class WelcomeCoordinator: Coordinator {

    private let coordinatorModel: WelcomeCoordinatorModel
    private let windowManager: WindowManager
    private weak var viewController: UIViewController?

    var next: Coordinator?
    weak var rootViewController: UIViewController?
    weak var delegate: WelcomeCoordinatorDelegate?

    init(coordinatorModel: WelcomeCoordinatorModel,
         windowManager: WindowManager,
         viewController: UIViewController?) {
        self.coordinatorModel = coordinatorModel
        self.windowManager = windowManager
        self.viewController = viewController
    }

    func start() {
        let viewController = coordinatorModel.welcomeViewController
        viewController.viewModel.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        rootViewController = navigationController
        viewController.present(navigationController, animated: true)
    }

}

extension WelcomeCoordinator: WelcomeViewModelDelegate {

    func welcomeViewModel(_ welcomeViewModel: WelcomeViewModel,
                          didRequestAuthenticationType type: AuthenticationType) {
        let viewController = coordinatorModel.authenticationViewController(type)
        viewController.viewModel.delegate = self
        (rootViewController as? UINavigationController)?.pushViewController(viewController, animated: true)
    }

    func welcomeViewModelDidRequestExit(_ welcomeViewModel: WelcomeViewModel) {
        rootViewController?.dismiss(animated: true)
    }

}

extension WelcomeCoordinator: AuthenticationViewModelDelegate {

    func authenticationViewModel(_ authenticationViewModel: AuthenticationViewModel, didBeginAuthentication type: AuthenticationType) {
        SVProgressHUD.show()
    }

    func authenticationViewModel(_ authenticationViewModel: AuthenticationViewModel, didFailAuthentication type: AuthenticationType) {
        SVProgressHUD.showError(withStatus: nil)
        SVProgressHUD.dismiss(withDelay: 0.5)
    }

    func authenticationViewModel(_ authenticationViewModel: AuthenticationViewModel, didSuceedAuthentication type: AuthenticationType) {
        SVProgressHUD.showSuccess(withStatus: nil)
        SVProgressHUD.dismiss(withDelay: 0.5) { [weak self] in
            guard let `self` = self else { return }
            self.rootViewController?.dismiss(animated: true)
            self.delegate?.welcomeCoordinatorDidSuceedAuthentication(self)
        }
    }

}
