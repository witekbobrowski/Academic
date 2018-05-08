//
//  CoordinatorModelFactory.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol CoordinatorModelFactory {
    var reviewCoordinatorModel: ReviewCoordinatorModel { get }
    var welcomeCoordinatorModel: WelcomeCoordinatorModel { get }
}

extension DependencyContainer: CoordinatorModelFactory {

    var reviewCoordinatorModel: ReviewCoordinatorModel {
        return ReviewCoordinatorModelImplementation(dependencyContainer: self)
    }

    var welcomeCoordinatorModel: WelcomeCoordinatorModel {
        return WelcomeCoordinatorModelImplementation(dependencyContainer: self)
    }

}
