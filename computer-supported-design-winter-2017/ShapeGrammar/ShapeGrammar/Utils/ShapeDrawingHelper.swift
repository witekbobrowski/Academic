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

    public func draw(_ grammar: ShapeGrammar, inShapeView shapeView: ShapeView) {
        var nodes = [grammar.head]
        shapeView.addPathForShape(nil)
        while let current = nodes.popLast() {
            shapeView.addPathForShape(current.element)
            nodes.append(contentsOf: current.nodes.values)
        }
    }
    
}
