//
//  Coordinator.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var next: Coordinator? { get set }
    var rootViewController: UIViewController? { get }
    func start()
}
