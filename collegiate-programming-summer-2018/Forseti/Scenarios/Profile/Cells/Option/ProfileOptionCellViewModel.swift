//
//  ProfileOptionCellViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 15/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol ProfileOptionCellViewModelDelegate: class {
    func profileOptionCellViewModel(_ profileOptionCellViewModel: ProfileOptionCellViewModel, didTapOption option: ProfileOption)
}

protocol ProfileOptionCellViewModel {
    var delegate: ProfileOptionCellViewModelDelegate? { get set }
    var title: String { get }
    func action()
}

class ProfileOptionCellViewModelImplementation: ProfileOptionCellViewModel {

    private let option: ProfileOption

    weak var delegate: ProfileOptionCellViewModelDelegate?
    var title: String { return option.description }

    init(option: ProfileOption) {
        self.option = option
    }

    func action() {
        delegate?.profileOptionCellViewModel(self, didTapOption: option)
    }

}
