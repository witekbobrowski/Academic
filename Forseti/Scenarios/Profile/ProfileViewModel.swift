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

    var numberOfSections: Int { get }
    func numberOfRows(inSection section: Int) -> Int
    func exit()
}

class ProfileViewModelImplementation: ProfileViewModel {

    private let userService: UserService

    private var user: User?

    var title: String {
        return "Profile"
    }
    var numberOfSections: Int {
        return 0
    }

    init(userService: UserService) {
        self.userService = userService
        self.fetchUser()
    }

    func numberOfRows(inSection section: Int) -> Int {
        return 0
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
