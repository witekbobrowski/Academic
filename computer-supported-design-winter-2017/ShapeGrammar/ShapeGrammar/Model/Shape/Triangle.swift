//
//  Triangle.swift
//  ShapeGrammar
//
//  Created by Witek on 20/11/2017.
//

import UIKit

struct Triangle: Shape {
    
    private enum Constants {
        static let spacingInRect: CGFloat = 8
    }
    
    public var rect: CGRect
    public var vertices: (CGPoint, CGPoint, CGPoint) = (.zero, .zero, .zero)
    public var size: CGFloat {
        let verts = [vertices.0.x, vertices.1.x, vertices.2.x].sorted()
        return verts.last! - verts.first!
    }
    public var height: CGFloat {
        let verts = [vertices.0.y, vertices.1.y, vertices.2.y].sorted()
        return verts.last! - verts.first!
    }
    public var center: CGPoint {
        let x = [vertices.0.x, vertices.1.x, vertices.2.x].sorted()[1]
        let y = [vertices.0.y, vertices.1.y, vertices.2.y].sorted().last! - (height / 2)
        return CGPoint(x: x, y: y)
    }
    public var isUpsideDown: Bool {
        let verts = [vertices.0, vertices.1, vertices.2].sorted(by: {$0.x<$1.x})
        return verts[0].y < verts[1].y
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

//MARK: - Private
extension Triangle {
    
    private func getVertices() -> (CGPoint, CGPoint, CGPoint) {
        let size = min(rect.height, rect.width) - 2 * Constants.spacingInRect
        let height = (size * sqrt(3))/2
        let vertexOne = CGPoint(x: rect.width/2 - size/2, y: (rect.height + height)/2)
        let vertexThree = CGPoint(x: rect.width/2, y: (rect.height - height)/2)
        let vertexTwo = CGPoint(x: rect.width/2 + size/2, y: (rect.height + height)/2)
        return (vertexOne, vertexTwo, vertexThree)
    }
    
}
