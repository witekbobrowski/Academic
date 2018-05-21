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
    func accountNumberActionCellViewModel(accountNumber: AccountNumber) -> AccountNumberActionCellViewModel
    func accountNumberCommentCellViewModel(comment: Comment,
                                           username: String) -> AccountNumberCommentCellViewModel

    func profileViewModel(userService: UserService) -> ProfileViewModel
    func profileAvatarCellViewModel(user: User) -> ProfileAvatarCellViewModel
    func thumbsActivityCellViewModel(thumbsDetails: ThumbsDetails, accountNumber: String) -> ThumbsActivityCellViewModel
    func commentActivityCellViewModel(comment: Comment, accountNumber: String) -> CommentActivityCellViewModel
    func profileOptionCellViewModel(option: ProfileOption) -> ProfileOptionCellViewModel

    func commentViewModel(accountNumber: AccountNumber, accountNumberService: AccountNumberService) -> CommentViewModel
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
        return AccountNumberViewModelImplementation(accountNumberService: accountNumberService,
                                                    dependencyContainer: self)
    }

    func accountNumberDetailsCellViewModel(accountNumber: AccountNumber) -> AccountNumberDetailsCellViewModel {
        return AccountNumberDetailsCellViewModelImplementation(accountNumber: accountNumber)
    }

    func accountNumberActionCellViewModel(accountNumber: AccountNumber) -> AccountNumberActionCellViewModel {
        return AccountNumberActionCellViewModelImplementation(accountNumber: accountNumber)
    }

    func accountNumberCommentCellViewModel(comment: Comment, username: String) -> AccountNumberCommentCellViewModel {
        return AccountNumberCommentCellViewModelImplementation(comment: comment, username: username)
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

    func commentViewModel(accountNumber: AccountNumber, accountNumberService: AccountNumberService) -> CommentViewModel {
        return CommentViewModelImplementation(accountNumber: accountNumber,
                                              accountNumberService: accountNumberService)
    }

}
