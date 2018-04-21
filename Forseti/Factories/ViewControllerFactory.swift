//
//  ViewControllerFactory.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol ViewControllerFactory {
    var reviewViewController: ReviewViewController { get }
}

extension DependencyContainer: ViewControllerFactory {

    var reviewViewController: ReviewViewController {
        let storyboard = storyboardProvider.storyboard(.review, bundle: nil)
        return storyboard.instantiateViewController(ReviewViewController.self)
    }

}
