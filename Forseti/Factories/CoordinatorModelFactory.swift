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
    func welcomeCoordinatorModel(client: Client) -> WelcomeCoordinatorModel
    func reviewCoordinatorModel(client: Client) -> ReviewCoordinatorModel
    func profileCoordinatorModel(client: Client) -> ProfileCoordinatorModel
}

extension DependencyContainer: CoordinatorModelFactory {

    func welcomeCoordinatorModel(client: Client) -> WelcomeCoordinatorModel {
        return WelcomeCoordinatorModelImplementation(client: client, dependencyContainer: self)
    }

    func reviewCoordinatorModel(client: Client) -> ReviewCoordinatorModel {
        return ReviewCoordinatorModelImplementation(client: client, dependencyContainer: self)
    }

    func profileCoordinatorModel(client: Client) -> ProfileCoordinatorModel {
        return ProfileCoordinatorModelImplementation(client: client, dependencyContainer: self)
    }

}
