//
//  ViewModelFactory.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol ViewModelFactory {
    var welcomeViewModel: WelcomeViewModel { get }

    func authenticationViewModel(authenticationService: AuthenticationService,
                                 type: AuthenticationType) -> AuthenticationViewModel
    func accountNumberViewModel(accountNumberService: AccountNumberService) -> AccountNumberViewModel
    func accountNumberDetailsCellViewModel(accountNumber: AccountNumber) -> AccountNumberDetailsCellViewModel

    func profileViewModel(userService: UserService) -> ProfileViewModel
    func profileAvatarCellViewModel(user: User) -> ProfileAvatarCellViewModel
    func thumbsActivityCellViewModel(thumbsDetails: ThumbsDetails, accountNumber: String) -> ThumbsActivityCellViewModel
    func commentActivityCellViewModel(comment: Comment, accountNumber: String) -> CommentActivityCellViewModel
    func profileOptionCellViewModel(option: ProfileOption) -> ProfileOptionCellViewModel
}

extension DependencyContainer: ViewModelFactory {

    var welcomeViewModel: WelcomeViewModel {
        return WelcomeViewModelImplementation()
    }

    func authenticationViewModel(authenticationService: AuthenticationService,
                                 type: AuthenticationType) -> AuthenticationViewModel {
        return AuthenticationViewModelImplementation(authenticationService: authenticationService,
                                                     type: type)
    }

    func accountNumberViewModel(accountNumberService: AccountNumberService) -> AccountNumberViewModel {
        return AccountNumberViewModelImplementation(accountNumberService: accountNumberService)
    }

    func accountNumberDetailsCellViewModel(accountNumber: AccountNumber) -> AccountNumberDetailsCellViewModel {
        return AccountNumberDetailsCellViewModelImplementation(accountNumber: accountNumber)
    }

    func profileViewModel(userService: UserService) -> ProfileViewModel {
        return ProfileViewModelImplementation(userService: userService, dependencyContainer: self)
    }

    func profileAvatarCellViewModel(user: User) -> ProfileAvatarCellViewModel {
        return ProfileAvatarCellViewModelImplementation(user: user)
    }

    func thumbsActivityCellViewModel(thumbsDetails: ThumbsDetails, accountNumber: String) -> ThumbsActivityCellViewModel {
        return ThumbsActivityCellViewModel(thumbsDetails: thumbsDetails, accountNumber: accountNumber)
    }

    func commentActivityCellViewModel(comment: Comment, accountNumber: String) -> CommentActivityCellViewModel {
        return CommentActivityCellViewModel(comment: comment, accountNumber: accountNumber)
    }

    func profileOptionCellViewModel(option: ProfileOption) -> ProfileOptionCellViewModel {
        return ProfileOptionCellViewModelImplementation(option: option)
    }

}
