//
//  UtilitiesFactory.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol UtilitiesFactory {
    var windowManager: WindowManager { get }
    var storyboardProvider: StoryboardProvider { get }
}
