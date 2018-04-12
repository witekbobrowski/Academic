//
//  AppDelegate.swift
//  Forseti
//
//  Created by Witek on 23/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        setupInitialFlow()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

}

extension AppDelegate {

    private func setupWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
    }

    private func setupInitialFlow() {
        let storyboard = UIStoryboard(name: "Review", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

}
