//
//  Star.swift
//  ShapeGrammar
//
//  Created by Witek on 20/11/2017.
//

import CoreGraphics

struct Star: Shape {
    
    private enum Constants {
        static let offsetRatio: CGFloat = 1/3
    }
    
    var rect: CGRect
    var triangles: (Triangle?, Triangle?)
    var center: CGPoint? {
        guard let triangleA = triangles.0, let triangleB = triangles.1 else { return nil }
        return CGPoint(x: triangleA.center.x, y: triangleA.center.y + (triangleB.center.y - triangleA.center.y)/2)
    }
    init(rect: CGRect) {
        self.rect = rect
        self.triangles = (nil, nil)
    }
    
    init(triangle: Triangle) {
        let offset = triangle.height * Constants.offsetRatio
        let isUpsideDown = triangle.isUpsideDown
        let difference = isUpsideDown ? -offset : offset
        var newTriangle = triangle.reversed()
        newTriangle.vertices.0.y += difference
        newTriangle.vertices.1.y += difference
        newTriangle.vertices.2.y += difference
        self.triangles = (triangle, newTriangle)
        self.rect = triangle.rect.union(newTriangle.rect)
    }
    
    init(triangles: (Triangle?, Triangle?)) {
        self.triangles = triangles
        self.rect = triangles.0?.rect.union(triangles.1?.rect ?? .zero) ?? .zero
    }

}
