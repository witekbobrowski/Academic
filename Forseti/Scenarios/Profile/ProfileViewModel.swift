//
//  ProfileViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 14/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol ProfileViewModel {
    var title: String { get }
    var tableHeaderViewModel: ProfileTableHeaderViewModel { get }
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

class ProfileViewModelImplementation: ProfileViewModel {

    private enum Activity {
        case thumb(ThumbsDetails, String)
        case comment(Comment, String)
    }

    private enum Section: Int {
        case options
        case activityFeed
    }

    private let userService: UserService
    private let dependencyContainer: DependencyContainer
    private let sections: [Section] = [.options, .activityFeed]
    private let options: [ProfileOption] = [.settings, .logout]

    private var user: User?
    private var activities: [Activity] = []

    var title: String { return "Profile" }
    var tableHeaderViewModel: ProfileTableHeaderViewModel {
        return dependencyContainer.profileTableHeaderViewModel(user: user!)
    }
    var numberOfSections: Int { return sections.count }

    init(userService: UserService, dependencyContainer: DependencyContainer) {
        self.userService = userService
        self.dependencyContainer = dependencyContainer
        self.fetchUser()
    }

    func numberOfRows(inSection section: Int) -> Int {
        let section = Section(rawValue: section)!
        switch section {
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

    func exit() {}

}

extension ProfileViewModelImplementation {

    private func fetchUser() {
        userService.getUser { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(error)
            }
        }
    }

}
