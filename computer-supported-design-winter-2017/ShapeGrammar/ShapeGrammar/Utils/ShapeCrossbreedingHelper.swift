//
//  ShapeCrossbreedingHelper.swift
//  ShapeGrammar
//
//  Created by Witek on 22/01/2018.
//

import Foundation

class ShapeCrossbreedingHelper {
    // Static instace of class for more convinient usage
    public static let shared = ShapeCrossbreedingHelper()
    
}

//MARK: - Public
extension ShapeCrossbreedingHelper {
    
    public func crossbreed(a: ShapeGrammar, b: ShapeGrammar) -> [ShapeGrammar] {
        var dnaPool = (a.getPaths() + b.getPaths()).sorted { $0.count < $1.count }
        dnaPool = Array(dnaPool.prefix(Int(arc4random_uniform(UInt32(dnaPool.count)))))
        var children: [ShapeGrammar] = []
        for _ in 0...Int(arc4random_uniform(4)) {
            let child = Grammar(element: a.head.element)
            dnaPool.forEach { applyPath($0, toNode: child.head) }
            if dnaPool.count < Int(arc4random_uniform(4)) + 2 {
                dnaPool.map { $0.flatMap { (arc4random_uniform(2) % 2 == 0) ? Location(rawValue: ($0.rawValue + 2) % 6) : $0.reversed }  }.forEach { applyPath($0, toNode: child.head) }
            }
            children.append(child)
        }
        return children
    }
    
}

//MARK: - Private
extension ShapeCrossbreedingHelper {

    public func applyPath(_ path: LocationPath, toNode node: Node) {
        var current = node
        var locations = Array(path.reversed())
        while let location = locations.popLast() {
            guard let element = ShapeBuildingHelper.shared.build(from: current.element, at: [location])[location] else { return }
            let node = Node(element: element)
            current.nodes[location] = node
            current = node
        }
    }

}
