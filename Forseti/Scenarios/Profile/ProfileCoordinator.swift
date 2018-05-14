//
//  ProfileCoordinator.swift
//  Forseti
//
//  Created by Witek Bobrowski on 14/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProfileCoordinator: Coordinator {

    private let coordinatorModel: ProfileCoordinatorModel
    private let viewControler: UIViewController?

    var next: Coordinator?
    weak var rootViewController: UIViewController?

    init(coordinatorModel: ProfileCoordinatorModel,
         viewControler: UIViewController?) {
        self.coordinatorModel = coordinatorModel
        self.viewControler = viewControler
    }

    func start() {
        let viewController = coordinatorModel.profileViewController
//        viewController.viewModel.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        rootViewController = navigationController
        self.viewControler?.present(navigationController, animated: true)
    }

}
