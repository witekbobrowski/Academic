//
//  TriangleView.swift
//  ShapeGrammar
//
//  Created by Witold Bobrowski on 24/10/2017.
//

import UIKit

class TriangleView: UIView {
    
    public var lineWidth: CGFloat = 3.0 { didSet { setNeedsDisplay() } }
    public var color: UIColor = UIColor.black { didSet { setNeedsDisplay() } }
    private var _isUpsideDown: Bool = false { didSet { setNeedsDisplay() } }
    public var isUpsideDown: Bool {
        get {
            return _isUpsideDown
        }
        set {
            if newValue != _isUpsideDown {
                UIView.transition(with: self, duration: 0.4, options: [.transitionFlipFromTop], animations: {
                    self._isUpsideDown = newValue
                })
            }
        }
    }
    
    public var size: CGFloat {
        return min(bounds.width, bounds.height)
    }
    
    public var height: CGFloat {
        return (size * sqrt(3))/2
    }
    
    override func draw(_ rect: CGRect) {
        var path: UIBezierPath
        if isUpsideDown {
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.width/2, y: bounds.height/2 + height/2))
            path.addLine(to: CGPoint(x: bounds.width/2 + size/2, y: bounds.height/2 - height/2))
            path.addLine(to: CGPoint(x: bounds.width/2 - size/2, y: bounds.height/2 - height/2))
            path.addLine(to: CGPoint(x: bounds.width/2, y: bounds.height/2 + height/2))
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.width/2, y: bounds.height/2 - height/2))
            path.addLine(to: CGPoint(x: bounds.width/2 + size/2, y: bounds.height/2 + height/2))
            path.addLine(to: CGPoint(x: bounds.width/2 - size/2, y: bounds.height/2 + height/2))
            path.addLine(to: CGPoint(x: bounds.width/2, y: bounds.height/2 - height/2))
        }
        path.lineWidth = lineWidth
        color.setStroke()
        path.stroke()
    }

}
