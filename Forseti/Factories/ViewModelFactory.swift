//
//  ViewModelFactory.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol ViewModelFactory {
    var reviewViewModel: ReviewViewModel { get }
}

extension DependencyContainer: ViewModelFactory {

    var reviewViewModel: ReviewViewModel {
        return ReviewViewModelImplementation(reviewService: 0)
    }

}
