//
//  ShapeGradingHelper.swift
//  ShapeGrammar
//
//  Created by Witek on 08/01/2018.
//

import Foundation

//  Grading function gives higher score for small and symetric shapes
//
//  For shape with :
//      0 embeded shape = 6 pts : always symmetric but lower score for quantity
//      1 embeded shape = 2 pts
//      2 embeded shape = 6 pts : +4 for symmetric pair : -2 for non-symmetric pair
//      3 embeded shape = 2 pts : gets lower score for being always non-symmetric
//      4 embeded shape = 4 pts : +3 for each symmetric pair : -2 for each non-symmetric pair
//      5 embeded shape = 2 pts : gets lower score for being always non-symme tric
//      6 embeded shape = 2 pts : always symmetric but lower score for quantity
//
//  Final score will be calculades as a result of adding above evaluation for each shape then
//  dividing by a number of shapes.
//  Finnaly the can be another penalty given for total number of shapes:
//      0 - 8 Total shapes = +2 pts
//      9 - 16 Total shapes = +0 pts
//      17 - 24 Total shapes = -2 pts
//      25 - 32 Total shapes = -4 pts
//      33 - X Total shapes = -(All points) Fatal penalty - shape too big!
//

class ShapeGradingHelper {
    
    // 0 - Worst, 10 - Best
    var score: Int = 0
    
}

//MARK: - Public
extension ShapeGradingHelper {
    
    public static func getGrade(fromGrammar head: Node) -> Int {
        let helper = ShapeGradingHelper()
        var scores: [Int] = []
        var nodes: [Node] = [head]
        while let current = nodes.popLast() {
            scores.append(helper.evaluateNode(current))
            nodes.append(contentsOf: current.nodes.flatMap {$0.value})
        }
        let average = scores.reduce(0, {$0+$1})/scores.count
        var penalty = 0
        switch scores.count {
        case 0...8:
            penalty = -2
        case 9...16:
            penalty = 0
        case 17...24:
            penalty = 2
        case 25...32:
            penalty = 4
        default:
            penalty = average
        }
        return average - penalty
    }
    
}

//MARK: - Private
extension ShapeGradingHelper {
    
    private func evaluateNode(_ node: Node) -> Int {
        var score: Int = 0
        let nodes = node.nodes.flatMap { $0.key }
        switch nodes.count {
        case 0:
            score = 6
        case 2:
            score = 6
            guard let first = nodes.first, let second = nodes.last else { break }
            score += areSummetrlyLayedOut(a: first, b: second) ? 4 : -2
        case 4:
            score = 4
            var results: [Bool] = []
            for index in 0..<3 {
                for latterIndex in (index + 1)..<4 {
                    results.append(areSummetrlyLayedOut(a: nodes[index], b: nodes[latterIndex]))
                }
            }
            let symmetricPairs = results.filter {$0}.count
            score += symmetricPairs == 2 ? 6 : symmetricPairs == 1 ? 1 : -4
        default:
            score = 2
        }
        return score
    }
    
    private func areSummetrlyLayedOut(a: Location, b: Location) -> Bool {
        switch a {
        case .north:
            return b == .south
        case .northEast:
            return b == .southWest
        case .southEast:
            return b == .northWest
        case .south:
            return b == .north
        case .southWest:
            return b == .northEast
        case .northWest:
            return b == .southEast
        case .center:
            return b == .center
        }
    }
    
}
