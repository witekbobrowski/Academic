//
//  ShapeGrammarBrain.swift
//  ShapeGrammar
//
//  Created by Witek on 20/11/2017.
//

import Foundation
import CoreGraphics

class ShapeGrammarBrain {
    
    public weak var delegate: ShapeGrammarBrainDelegate?
    
}

extension ShapeGrammarBrain {
    
    public func defineTriangles(in star: Star) {
        
    }
    
}

protocol ShapeGrammarBrainDelegate: AnyObject {
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didEndCalculatingShape shape: Shape)
}
