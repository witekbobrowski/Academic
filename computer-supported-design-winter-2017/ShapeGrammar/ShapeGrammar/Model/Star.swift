//
//  Star.swift
//  ShapeGrammar
//
//  Created by Witek on 20/11/2017.
//

import CoreGraphics

struct Star: Shape {
    
    var rect: CGRect
    var triangles: (Triangle?, Triangle?)
    var center: CGPoint? {
        guard let triangleA = triangles.0, let triangleB = triangles.1 else { return nil }
        let diffetence = (triangleB.center.y - triangleA.center.y)/2
        return CGPoint(x: triangleA.center.x, y: triangleA.center.y + (triangleB.center.y - triangleA.center.y)/2)
    }
    init(rect: CGRect) {
        self.rect = rect
        self.triangles = (nil, nil)
    }
    
    init(triangles: (Triangle?, Triangle?)) {
        self.triangles = triangles
        self.rect = triangles.0?.rect.union(triangles.1?.rect ?? .zero) ?? .zero
    }

}
