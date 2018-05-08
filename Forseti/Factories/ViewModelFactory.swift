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
    var authenticationViewModel: AuthenticationViewModel { get }

}

extension DependencyContainer: ViewModelFactory {

    var reviewViewModel: ReviewViewModel {
        return ReviewViewModelImplementation(reviewService: 0)
    }

    var welcomeViewModel: WelcomeViewModel {
        return WelcomeViewModelImplementation()
    }

    var authenticationViewModel: AuthenticationViewModel {
        return AuthenticationViewModelImplementation()
    }

}
