//
//  ShapeDrawingHelper.swift
//  ShapeGrammar
//
//  Created by Witek on 14/01/2018.
//

import UIKit

class ShapeDrawingHelper {
    
    // Static instace of class for more convinient usage
    public static let shared = ShapeDrawingHelper()
    
}

//MARK: - Public
extension ShapeDrawingHelper {

    public func getPathForGrammar(_ grammar: ShapeGrammar) -> UIBezierPath {
        var nodes = [grammar.head]
        let path = UIBezierPath()
        while let current = nodes.popLast() {
            addPathForShape(current.element, toPath: path)
            nodes.append(contentsOf: current.nodes.values)
        }
        return path
    }
    
    public func addPathForShape(_ shape: Shape, toPath path: UIBezierPath?) {
        var triangles: [Triangle] = []
        if let triangle = shape as? Triangle {
            triangles = [triangle]
        } else if let star = shape as? Star {
            triangles = [star.triangles.1, star.triangles.0].flatMap { $0 }
        }
        triangles.forEach { triangle in addPathForTriangle(triangle, toPath: path) }
    }
    
    public func addPathForTriangle(_ triangle: Triangle, toPath path: UIBezierPath?) {
        path?.move(to: triangle.vertices.0)
        [triangle.vertices.1, triangle.vertices.2, triangle.vertices.0].forEach { path?.addLine(to: $0) }
    }
    
}
