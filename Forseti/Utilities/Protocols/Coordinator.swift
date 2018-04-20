//
//  Coordinator.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol Coordinator {
    var next: Coordinator? { get set }
    func start()
}
