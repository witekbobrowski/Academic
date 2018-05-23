//
//  ProfileViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 14/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol ProfileViewModelDelegate: class {
    func profileViewModelDidBeginFetchingUser(_ profileViewModel: ProfileViewModel)
    func profileViewModel(_ profileViewModel: ProfileViewModel, didFinishFetchingUser user: User)
    func profileViewModel(_ profileViewModel: ProfileViewModel, didFailFetchingWithError error: Error)
    func profileViewModelDidRequestExit(_ profileViewModel: ProfileViewModel)
}

protocol ProfileViewModel {
    var delegate: ProfileViewModelDelegate? { get set }
    var title: String { get }
    var avatarCellViewModel: ProfileAvatarCellViewModel { get }
    var numberOfSections: Int { get }
    func numberOfRows(inSection section: Int) -> Int
    func viewModel(forOptionCellInRow row: Int) -> ProfileOptionCellViewModel
    func viewModel(forActivityCellInRow row: Int) -> ProfileActivityCellViewModel
    func exit()
}

enum ProfileOption {
    case settings
    case logout

    var description: String {
        switch self {
        case .settings: return "Settings"
        case .logout: return "Log out"
        }
    }
}

extension Notification.Name {
    static var profileViewModelDidFetchUser: Notification.Name {
        return Notification.Name(rawValue: "ProfileViewModel.profileViewModelDidFetchUser")
    }
}

class ProfileViewModelImplementation: ProfileViewModel {

    private enum Activity {
        case thumb(ThumbsDetails, String)
        case comment(Comment, String)
    }

    private enum Section: Int {
        case avatar
        case options
        case activityFeed
    }

    private let userService: UserService
    private let dependencyContainer: DependencyContainer
    private let sections: [Section] = [.avatar, .options, .activityFeed]
    private let options: [ProfileOption] = [.settings, .logout]

    private var user: User?
    private var activities: [Activity] = []

    weak var delegate: ProfileViewModelDelegate? { didSet { fetchUser() } }
    var title: String { return "Profile" }
    var avatarCellViewModel: ProfileAvatarCellViewModel {
        return dependencyContainer.profileAvatarCellViewModel(user: user!)
    }
    var numberOfSections: Int { return sections.count }

    init(userService: UserService, dependencyContainer: DependencyContainer) {
        self.userService = userService
        self.dependencyContainer = dependencyContainer
    }

    func numberOfRows(inSection section: Int) -> Int {
        let section = Section(rawValue: section)!
        switch section {
        case .avatar: return user == nil ? 0 : 1
        case .options: return options.count
        case .activityFeed: return activities.count
        }
    }

    func viewModel(forOptionCellInRow row: Int) -> ProfileOptionCellViewModel {
        return dependencyContainer.profileOptionCellViewModel(option: options[row])
    }

    func viewModel(forActivityCellInRow row: Int) -> ProfileActivityCellViewModel {
        switch activities[row] {
        case .thumb(let thumb, let number):
            return  dependencyContainer.thumbsActivityCellViewModel(thumbsDetails: thumb, accountNumber: number)
        case .comment(let comment, let number):
            return dependencyContainer.commentActivityCellViewModel(comment: comment, accountNumber: number)
        }
    }

    func exit() {
        delegate?.profileViewModelDidRequestExit(self)
    }

}

extension ProfileViewModelImplementation {

    private func fetchUser() {
        delegate?.profileViewModelDidBeginFetchingUser(self)
        userService.getUser { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let user):
                self.user = user
                user.thumbsDetails.forEach { entry in self.activities.append(.thumb(entry.value, entry.key))}
                user.comments.forEach { (account, comments) in
                    comments.forEach { comment in
                        self.activities.append(.comment(comment, account))
                    }
                }
                self.activities.sort { activityA, activityB in
                    var aDate: Date?
                    var bDate: Date?
                    switch activityA {
                    case .comment(let comment, _): aDate = comment.date
                    case .thumb(let thumb, _): aDate = thumb.date
                    }
                    switch activityB {
                    case .comment(let comment, _): bDate = comment.date
                    case .thumb(let thumb, _): bDate = thumb.date
                    }
                    return (aDate ?? Date()) > (bDate ?? Date())
                }
                NotificationCenter.default.post(name: .profileViewModelDidFetchUser, object: self)
                self.delegate?.profileViewModel(self, didFinishFetchingUser: user)
            case .failure(let error):
                self.delegate?.profileViewModel(self, didFailFetchingWithError: error)
            }
        }
    }

}
