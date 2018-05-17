//
//  ReviewCoordinatorModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol ReviewCoordinatorModel {
    var reviewViewController: ReviewViewController { get }
    func profileCoordinator(viewController: UIViewController?) -> ProfileCoordinator
}

class ReviewCoordinatorModelImplementation: ReviewCoordinatorModel {

    private let client: Client
    private let dependencyContainer: DependencyContainer

    var reviewViewController: ReviewViewController {
        return configuredReviewViewController()
    }

    init(client: Client, dependencyContainer: DependencyContainer) {
        self.client = client
        self.dependencyContainer = dependencyContainer
    }

    func profileCoordinator(viewController: UIViewController?) -> ProfileCoordinator {
        return dependencyContainer.profileCoordinator(client: client, viewController: viewController)
    }

}

extension ReviewCoordinatorModelImplementation {

    func configuredReviewViewController() -> ReviewViewController {
        let viewModel = dependencyContainer.reviewViewModel(accountNumberService: client.accountNumberService)
        let viewController = dependencyContainer.reviewViewController
        viewController.viewModel = viewModel
        return viewController
    }

}
