//
//  CoordinatorModelFactory.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol CoordinatorModelFactory {
    var reviewCoordinatorModel: ReviewCoordinatorModel { get }
    func welcomeCoordinatorModel(client: Client) -> WelcomeCoordinatorModel
    func profileCoordinatorModel(client: Client) -> ProfileCoordinatorModel
}

extension DependencyContainer: CoordinatorModelFactory {

    var reviewCoordinatorModel: ReviewCoordinatorModel {
        return ReviewCoordinatorModelImplementation(dependencyContainer: self)
    }

    func welcomeCoordinatorModel(client: Client) -> WelcomeCoordinatorModel {
        return WelcomeCoordinatorModelImplementation(client: client, dependencyContainer: self)
    }

    func profileCoordinatorModel(client: Client) -> ProfileCoordinatorModel {
        return ProfileCoordinatorModelImplementation(client: client, dependencyContainer: self)
    }

}
