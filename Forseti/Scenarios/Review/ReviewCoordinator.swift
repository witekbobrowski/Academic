//
//  ReviewCoordinator.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit
import ForsetiApiKit

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
        let navigationController = UINavigationController(rootViewController: viewController)
        rootViewController = navigationController
        windowManager.setRoot(navigationController)
        (UIApplication.shared.delegate as? AppDelegate)?.window = windowManager.window
    }

}

extension ReviewCoordinator: ReviewViewModelDelegate {

    func reviewViewModel(_ reviewViewModel: ReviewViewModel, didBeginSearchingFor accountNumber: String) {
        print("\(type(of: reviewViewModel)) did begin searching for account with number: \(accountNumber)")
    }

    func reviewViewModel(_ reviewViewModel: ReviewViewModel, didFindAccountNumber accountNumber: AccountNumber) {
        print("\(type(of: reviewViewModel)) did find account with number: \(accountNumber.accountNumber)")
    }

    func reviewViewModel(_ reviewViewModel: ReviewViewModel, didFailSearchingWithError error: Error) {
        print("\(type(of: reviewViewModel)) did fail searching with error: \(error)")
    }

}
