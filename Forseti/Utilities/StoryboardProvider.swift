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
}

protocol StoryboardProvider {
    func storyboard(_ type: StoryboardType, bundle: Bundle?) -> UIStoryboard
}

class ForsetiStoryboardProvider {
    func storyboard(_ type: StoryboardType, bundle: Bundle?) -> UIStoryboard {
        return UIStoryboard(name: type.rawValue, bundle: bundle)
    }
}
