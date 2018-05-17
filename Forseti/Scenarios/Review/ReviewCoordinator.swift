//
//  ReviewCoordinator.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class ReviewCoordinator: Coordinator {

    private let coordinatorModel: ReviewCoordinatorModel
    private let windowManager: WindowManager

    var next: Coordinator?
    weak var rootViewController: UIViewController?

    init(coordinatorModel: ReviewCoordinatorModel,
         windowManager: WindowManager) {
        self.coordinatorModel = coordinatorModel
        self.windowManager = windowManager
    }

    func start() {
        let viewController = coordinatorModel.reviewViewController
        viewController.viewModel.delegate = self
        rootViewController = viewController
        windowManager.setRoot(viewController)
        (UIApplication.shared.delegate as? AppDelegate)?.window = windowManager.window
    }

}

extension ReviewCoordinator: ReviewViewModelDelegate {

    func reviewViewModel(_ reviewViewModel: ReviewViewModel) {}

}
