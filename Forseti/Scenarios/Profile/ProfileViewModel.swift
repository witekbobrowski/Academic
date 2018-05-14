//
//  ProfileViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 14/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol ProfileViewModel {
    var title: String { get }

    var numberOfSections: Int { get }
    func numberOfRows(inSection section: Int) -> Int
    func exit()
}
