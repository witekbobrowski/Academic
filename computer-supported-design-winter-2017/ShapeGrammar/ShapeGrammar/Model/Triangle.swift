//
//  Triangle.swift
//  ShapeGrammar
//
//  Created by Witek on 20/11/2017.
//

import CoreGraphics

struct Triangle: Shape {
    
    public var rect: CGRect
    public var vertices: (a: CGPoint, b: CGPoint, c: CGPoint)
    public var isUpsiteDown: Bool {
        return vertices.a.y == vertices.b.y ? vertices.a.y < vertices.c.y : (vertices.a.y == vertices.c.y ? vertices.a.y < vertices.b.y : vertices.b.y < vertices.a.y )
    }
    
    init(rect: CGRect) {
        self.rect = rect
        self.vertices = (.zero, .zero, .zero)
    }
    
}
