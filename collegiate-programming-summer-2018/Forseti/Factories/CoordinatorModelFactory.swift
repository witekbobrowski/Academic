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
    func accountNumberCoordinatorModel(client: Client) -> AccountNumberCoordinatorModel
    func profileCoordinatorModel(client: Client) -> ProfileCoordinatorModel
}

extension DependencyContainer: CoordinatorModelFactory {

    func welcomeCoordinatorModel(client: Client) -> WelcomeCoordinatorModel {
        return WelcomeCoordinatorModelImplementation(client: client, dependencyContainer: self)
    }

    func accountNumberCoordinatorModel(client: Client) -> AccountNumberCoordinatorModel {
        return AccountNumberCoordinatorModelImplementation(client: client, dependencyContainer: self)
    }

    func profileCoordinatorModel(client: Client) -> ProfileCoordinatorModel {
        return ProfileCoordinatorModelImplementation(client: client, dependencyContainer: self)
    }

}
