//
//  Triangle.swift
//  ShapeGrammar
//
//  Created by Witek on 20/11/2017.
//

import CoreGraphics

struct Triangle: Shape {
    
    public var rect: CGRect
    public var vertices: (CGPoint, CGPoint, CGPoint) = (.zero, .zero, .zero)
    public var size: CGFloat {
        return vertices.0.y == vertices.1.y ? abs(vertices.0.x - vertices.1.x) : (vertices.0.y == vertices.2.y ? abs(vertices.0.x - vertices.2.x) : abs(vertices.1.x - vertices.2.x))
    }
    public var height: CGFloat {
        return (size * sqrt(3))/2
    }
    public var center: CGPoint {
        let x = vertices.0.x < vertices.1.x ? (vertices.1.x < vertices.2.x ? vertices.1.x : vertices.2.x) : (vertices.0.x < vertices.2.x ? vertices.0.x : (vertices.1.x < vertices.2.x ? vertices.2.x : vertices.1.x))
        let y = vertices.0.y != vertices.1.y ? (min(vertices.0.y, vertices.1.y) + height/2) : vertices.0.y != vertices.2.y ? (min(vertices.0.y, vertices.2.y) + height/2) : (min(vertices.1.y, vertices.2.y) + height/2)
        return CGPoint(x: x, y: y)
    }
    public var isUpsideDown: Bool {
        return vertices.0.y == vertices.1.y ? vertices.0.y < vertices.2.y : (vertices.0.y == vertices.2.y ? vertices.0.y < vertices.1.y : vertices.1.y < vertices.0.y )
    }
    
    init(rect: CGRect) {
        self.rect = rect
        self.vertices = getVertices()
    }

    init(rect: CGRect, vertices: (CGPoint, CGPoint, CGPoint)) {
        self.rect = rect
        self.vertices = vertices
    }
    
    public func reversed() -> Triangle {
        let center = self.center
        let height = self.height
        let vertexOne = CGPoint(x: vertices.0.x, y: vertices.0.y < center.y ? vertices.0.y + height : vertices.0.y - height)
        let vertexThree = CGPoint(x: vertices.1.x, y: vertices.1.y < center.y ? vertices.1.y + height : vertices.1.y - height)
        let vertexTwo = CGPoint(x: vertices.2.x, y: vertices.2.y < center.y ? vertices.2.y + height : vertices.2.y - height)
        return Triangle(rect: rect, vertices: (vertexOne, vertexTwo, vertexThree))
    }
    
}

//MARK: - Configuration
extension Triangle {
    
    private func getVertices() -> (CGPoint, CGPoint, CGPoint) {
        let size = min(rect.height, rect.width)
        let height = (size * sqrt(3))/2
        let vertexOne = CGPoint(x: rect.width/2 - size/2, y: (rect.height + height)/2)
        let vertexThree = CGPoint(x: rect.width/2, y: (rect.height - height)/2)
        let vertexTwo = CGPoint(x: rect.width/2 + size/2, y: (rect.height + height)/2)
        return (vertexOne, vertexTwo, vertexThree)
    }
    
}
