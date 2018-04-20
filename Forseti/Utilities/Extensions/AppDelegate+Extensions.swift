//
//  AppDelegate+Extensions.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

extension AppDelegate {

    func setupWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
    }

    func setupInitialFlow() {
        let storyboard = StoryboardProvider.storyboard(.review, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: ReviewViewController.name) as! ReviewViewController
        let viewModel = ReviewViewModelImplementation(reviewService: "")
        viewController.viewModel = viewModel
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

}
