//
//  ProfileTableHeaderViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 15/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

protocol ProfileTableHeaderViewModel {
    var name: String { get }
}

class ProfileTableHeaderViewModelImplementation: ProfileTableHeaderViewModel {

    private let user: User

    var name: String { return user.username }

    init(user: User) {
        self.user = user
    }

}
