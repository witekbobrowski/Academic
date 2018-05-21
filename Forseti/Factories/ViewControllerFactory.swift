//
//  ViewControllerFactory.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol ViewControllerFactory {
    var welcomeViewController: WelcomeViewController { get }
    var authenticationViewController: AuthenticationViewController { get }
    var accountNumberViewController: AccountNumberViewController { get }
    var commentViewController: CommentViewController { get }
    var profileViewController: ProfileViewController { get }
}

extension DependencyContainer: ViewControllerFactory {

    var welcomeViewController: WelcomeViewController {
        let storyboard = storyboardProvider.storyboard(.welcome, bundle: nil)
        return storyboard.instantiateViewController(WelcomeViewController.self)
    }
    var authenticationViewController: AuthenticationViewController {
        let storyboard = storyboardProvider.storyboard(.welcome, bundle: nil)
        return storyboard.instantiateViewController(AuthenticationViewController.self)
    }
    var accountNumberViewController: AccountNumberViewController {
        let storyboard = storyboardProvider.storyboard(.accountNumber, bundle: nil)
        return storyboard.instantiateViewController(AccountNumberViewController.self)
    }
    var commentViewController: CommentViewController {
        let storyboard = storyboardProvider.storyboard(.accountNumber, bundle: nil)
        return storyboard.instantiateViewController(CommentViewController.self)
    }
    var profileViewController: ProfileViewController {
        let storyboard = storyboardProvider.storyboard(.profile, bundle: nil)
        return storyboard.instantiateViewController(ProfileViewController.self)
    }

}
