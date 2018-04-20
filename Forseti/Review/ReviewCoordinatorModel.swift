//
//  ReviewCoordinatorModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol ReviewCoordinatorModel {
    var reviewViewController: ReviewViewController { get }
}

class ReviewCoordinatorModelImplementation: ReviewCoordinatorModel {

    private let dependencyContainer: DependencyContainer

    var reviewViewController: ReviewViewController {
        return configuredReviewViewController()
    }

    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
    }

}

extension ReviewCoordinatorModelImplementation {

    func configuredReviewViewController() -> ReviewViewController{
        let viewModel = dependencyContainer.reviewViewModel
        let viewController = dependencyContainer.reviewViewController
        viewController.viewModel = viewModel
        return viewController
    }

}
