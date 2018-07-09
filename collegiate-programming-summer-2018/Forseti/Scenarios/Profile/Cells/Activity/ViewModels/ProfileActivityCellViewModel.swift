//
//  ProfileActivityCellViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 15/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol ProfileActivityCellViewModel {
    var title: String { get }
    var date: String { get }

    func action()
}
