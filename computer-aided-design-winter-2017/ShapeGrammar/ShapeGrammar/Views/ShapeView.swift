 //
//  ShapeView.swift
//  ShapeGrammar
//
//  Created by Witold Bobrowski on 24/10/2017.
//

import UIKit

class ShapeView: UIView {
    
    public var lineWidth: CGFloat = 1.5 { didSet { setNeedsDisplay() } }
    public var color: UIColor = UIColor.black { didSet { setNeedsDisplay() } }
    public var path = UIBezierPath() { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        color.setStroke()
        path.stroke()
    }

    public func addPathForShape(_ shape: Shape) {
        ShapeDrawingHelper.shared.addPathForShape(shape, toPath: path)
    }
    
}
