//
//  ShapeGradingHelper.swift
//  ShapeGrammar
//
//  Created by Witek on 08/01/2018.
//
//  Grading function gives higher score for small and symetric shapes
//
//  For shape with :
//      0 embeded shape = 6 pts : always symmetric but lower score for quantity
//      1 embeded shape = 2 pts
//      2 embeded shape = 6 pts : +4 for symmetric pair : -2 for non-symmetric pair
//      3 embeded shape = 6 pts : +4 for symmetric triplet : -2 for non-symmetric triplet
//      4 embeded shape = 4 pts : +3 for each symmetric pair : -2 for each non-symmetric pair
//      5 embeded shape = 2 pts : gets lower score for being always non-symme tric
//      6 embeded shape = 2 pts : always symmetric but lower score for quantity
//
//  Final score will be calculades as a result of adding above evaluation for each shape then
//  dividing by a number of shapes.
//  Finnaly the can be another penalty given for total number of shapes:
//      0 - 1 Total evaluated shapes = +1 pts
//      2 - 4 Total evaluated shapes = -1 pts
//      5 - 16 Total evaluated shapes = -3 pts
//      17 - X Total evaluated shapes = -(All points) Fatal penalty - shape too big!
//

import Foundation

class ShapeGradingHelper {
    // Static instace of class for more convinient usage
    public static let shared = ShapeGradingHelper()
    
}

//MARK: - Public
extension ShapeGradingHelper {
    
    // returns score from 0-10 evaluating node and its child nodes respectively with specifiacation above
    public func getGrade(fromGrammar head: Node) -> Int {
        var scores: [Int] = []
        var nodes: [Node] = [head]
        // while there is something in the array of nodes pop item and assing it to the `current` variable
        while let current = nodes.popLast() {
            // evaluation of node returns score from 0-10, append the score to array `scores`
            guard let score = evaluateNode(current) else { continue }
            scores.append(score)
            // append all children nodes for further evaluation
            nodes.append(contentsOf: current.nodes.flatMap {$0.value})
        }
        return calculateFinalScore(fromScores: scores)
    }
    
}

//MARK: - Private
extension ShapeGradingHelper {
    
    // Find the number of child nodes and return appropiate score
    private func evaluateNode(_ node: Node) -> Int? {
        var score: Int = 0
        let nodes = node.nodes.flatMap { $0.key }
        switch nodes.count {
        case 0:
            return nil
        case 2:
            score = 6
            score += areSummetrlyLayedOut(a: nodes[0], b: nodes[1], c: nil) ? 4 : -2
        case 3:
            score = 6
            score += areSummetrlyLayedOut(a: nodes[0], b: nodes[1], c: nodes[2]) ? 4 : -4
        case 4:
            score = 4
            var results: [Bool] = []
            for index in 0..<3 {
                for latterIndex in (index + 1)..<4 {
                    results.append(areSummetrlyLayedOut(a: nodes[index], b: nodes[latterIndex], c: nil))
                }
            }
            let symmetricPairs = results.filter {$0}.count
            score += symmetricPairs == 2 ? 4 : symmetricPairs == 1 ? 2 : -2
        default:
            score = 2
        }
        return score
    }
    
    // Compare two locations to check ther relative position
    private func areSummetrlyLayedOut(a: Location, b: Location, c: Location?) -> Bool {
        guard let c = c else { return a == b.reversed }
        switch a {
        case .north:
            return [b, c].contains(.southEast) && [b, c].contains(.southWest)
        case .northEast:
            return [b, c].contains(.south) && [b, c].contains(.northWest)
        case .southEast:
            return [b, c].contains(.north) && [b, c].contains(.southWest)
        case .south:
            return [b, c].contains(.northWest) && [b, c].contains(.northEast)
        case .southWest:
            return [b, c].contains(.southEast) && [b, c].contains(.north)
        case .northWest:
            return [b, c].contains(.south) && [b, c].contains(.northEast)
        case .center:
            return b == .center && c == .center
        }
    }
    
    // Calculate average from gathered scores and apply penalty
    private func calculateFinalScore(fromScores scores: [Int]) -> Int {
        guard scores.count > 0 else { return 2 }
        let average = scores.reduce(0, {$0+$1})/scores.count
        var penalty = 0
        // figure out penalty for the number of nodes as described above
        switch scores.count {
        case 0...1:
            penalty = -1
        case 2...4:
            penalty = 1
        case 5...16:
            penalty = 3
        default:
            penalty = average
        }
        // return calculated average with subrtacting the penalty
        return max(1, min(10, average - penalty))
    }
    
}
