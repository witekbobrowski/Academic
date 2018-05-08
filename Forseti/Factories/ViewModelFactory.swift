//
//  ViewModelFactory.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol ViewModelFactory {
    var reviewViewModel: ReviewViewModel { get }
    var welcomeViewModel: WelcomeViewModel { get }
    func authenticationViewModel(_ type: AuthenticationType) -> AuthenticationViewModel

}

extension DependencyContainer: ViewModelFactory {

    var reviewViewModel: ReviewViewModel {
        return ReviewViewModelImplementation(reviewService: 0)
    }

    var welcomeViewModel: WelcomeViewModel {
        return WelcomeViewModelImplementation()
    }

    func authenticationViewModel(_ type: AuthenticationType) -> AuthenticationViewModel {
        return AuthenticationViewModelImplementation(type: type)
    }

}
