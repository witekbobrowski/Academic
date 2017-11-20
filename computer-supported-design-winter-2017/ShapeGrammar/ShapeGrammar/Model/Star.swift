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
    
    init(rect: CGRect) {
        self.rect = rect
        self.triangles = (nil, nil)
    }
    
    init(triangles: (Triangle?, Triangle?)) {
        self.triangles = triangles
        self.rect = triangles.0?.rect.union(triangles.1?.rect ?? .zero) ?? .zero
    }

}
