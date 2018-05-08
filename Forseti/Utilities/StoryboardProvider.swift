//
//  StoryboardProvider.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

enum StoryboardType: String {
    case review = "Review"
    case welcome = "Welcome"
}

protocol StoryboardProvider {
    /// Core `StoryboardProvider` protocol method. Takes advetage of the `StoryboardType` enumeration
    /// to return approriate `UIStoryboard` object for initialising UIViewController represented in the
    /// relative storyboard file.
    ///
    /// - Parameters:
    ///   - type: `StoryboardType` enumeration case, relative to actual storyboard file
    ///   - bundle: The bundle containing the storyboard file and its related resources.
    ///     If you specify nil, this method looks in the main bundle of the current application.
    /// - Returns: `UIStoryboard` instance
    func storyboard(_ type: StoryboardType, bundle: Bundle?) -> UIStoryboard
}

class ForsetiStoryboardProvider: StoryboardProvider {
    func storyboard(_ type: StoryboardType, bundle: Bundle?) -> UIStoryboard {
        return UIStoryboard(name: type.rawValue, bundle: bundle)
    }
}
