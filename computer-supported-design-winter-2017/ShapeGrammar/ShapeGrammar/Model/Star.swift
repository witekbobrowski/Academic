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
    var triangles: (Triangle, Triangle)
    var center: CGPoint? {
        return CGPoint(x: triangles.0.center.x, y: triangles.0.center.y + (triangles.1.center.y - triangles.0.center.y)/2)
    }
    init(rect: CGRect) {
        let triangle = Triangle(rect: rect)
        self.init(triangle: triangle)
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
    
    init(triangles: (Triangle, Triangle)) {
        self.triangles = triangles
        self.rect = triangles.0.rect.union(triangles.1.rect)
    }

}
