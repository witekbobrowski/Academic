//
//  WindowManager.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

protocol WindowManager {
    var window: UIWindow { get }
    func setRoot(_ viewController: UIViewController)
}

class ForsetiWindowManager: WindowManager {

    private (set) var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func setRoot(_ viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

}
