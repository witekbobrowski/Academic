//
//  UtilityFactory.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

protocol UtilityFactory {
    var windowManager: WindowManager { get }
    var storyboardProvider: StoryboardProvider { get }
}

extension DependencyContainer: UtilityFactory {

    var windowManager: WindowManager {
        return ForsetiWindowManager(window: UIWindow(frame: UIScreen.main.bounds))
    }

    var storyboardProvider: StoryboardProvider {
        return ForsetiStoryboardProvider()
    }

}
