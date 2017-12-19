//
//  Location.swift
//  ShapeGrammar
//
//  Created by Witold Bobrowski on 19/12/2017.
//

import Foundation

public typealias LocationPath = [Location]

enum LocationPathError: Error {
    case PathOutOfRange
}

public enum Location: Int {
    case north = 0
    case northEast = 1
    case southEast = 2
    case south = 3
    case southWest = 4
    case northWest = 5
    case center = 6
}
