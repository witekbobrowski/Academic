//
//  AppDelegate+Extensions.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

extension AppDelegate {

    func setupInitialFlow() {
        let windowManager = ForsetiWindowManager(window: UIWindow(frame: UIScreen.main.bounds))
        window = windowManager.window
        let storyboardProvider = ForsetiStoryboardProvider()
        let storyboard = storyboardProvider.storyboard(.review, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: ReviewViewController.name) as! ReviewViewController
        let viewModel = ReviewViewModelImplementation(reviewService: "")
        viewController.viewModel = viewModel
        windowManager.setRoot(viewController)
    }

}
