//
//  Coordinator.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

protocol Coordinator: class {
    var next: Coordinator? { get set }
    func start()
}
