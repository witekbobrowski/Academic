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

    public func addPathForShape(_ shape: Shape?) {
        var triangles: [Triangle] = []
        if let triangle = shape as? Triangle {
            triangles = [triangle]
        } else if let star = shape as? Star {
            triangles = [star.triangles.1, star.triangles.0].flatMap { $0 }
        } else {
            self.path = UIBezierPath()
            return
        }
        let path = self.path
        for triangle in triangles {
            path.move(to: triangle.vertices.0)
            [triangle.vertices.1, triangle.vertices.2, triangle.vertices.0].forEach { path.addLine(to: $0) }
        }
        self.path = path
    }
    
}
