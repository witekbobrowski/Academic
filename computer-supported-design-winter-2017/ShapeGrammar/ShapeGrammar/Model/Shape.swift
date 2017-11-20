//
//  Shape.swift
//  ShapeGrammar
//
//  Created by Witek on 20/11/2017.
//

import CoreGraphics

protocol Shape {
    var rect: CGRect { get set }
    init(rect: CGRect)
}
