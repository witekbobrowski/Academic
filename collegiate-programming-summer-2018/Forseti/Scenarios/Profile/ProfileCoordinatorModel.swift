//
//  ProfileCoordinatorModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 14/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol ProfileCoordinatorModel {
    var profileViewController: ProfileViewController { get }
}

class ProfileCoordinatorModelImplementation: ProfileCoordinatorModel {

    private let dependencyContainer: DependencyContainer
    private let client: Client

    var profileViewController: ProfileViewController {
        return configuredProfileViewController()
    }

    init(client: Client,
         dependencyContainer: DependencyContainer) {
        self.client = client
        self.dependencyContainer = dependencyContainer
    }

}

extension ProfileCoordinatorModelImplementation {

    func configuredProfileViewController() -> ProfileViewController {
        let viewModel = dependencyContainer.profileViewModel(userService: client.userService,
                                                             authenticationService: client.authenticationService)
        let viewController = dependencyContainer.profileViewController
        viewController.viewModel = viewModel
        return viewController
    }

}
