//
//  ShapeGrammarBrain.swift
//  ShapeGrammar
//
//  Created by Witek on 20/11/2017.
//

import CoreGraphics

class ShapeGrammarBrain {

    private enum Constants {
        static let offsetRatio: CGFloat = 1/3
    }

    public weak var delegate: ShapeGrammarBrainDelegate?
    
    private var stars: [[Star]] = []
    
    public var isEmpty: Bool {
        return stars.isEmpty
    }
    
}

//MARK: - Configuration
extension ShapeGrammarBrain {
    
    public func clear() {
        stars = []
    }
    
    public func addShape(_ shape: Shape) {
        if let triangle = shape as? Triangle {
            stars.append([Star(triangles: (triangle, nil))])
        } else if let star = shape as? Star {
            stars.append([star])
        }
        delegate?.shapeGrammarBrain(self, didBuildShape: shape)
    }
    
    public func buildShapes() {
        guard let stars = stars.last else {
            return
        }
        var newStars: [Star] = []
        var triangles: [Triangle] = []
        for star in stars {
            triangles.append(contentsOf: defineTriangles(in: star))
        }
        for triangle in triangles {
            let star = buildStar(from: triangle)
            newStars.append(star)
            delegate?.shapeGrammarBrain(self, didBuildShape: star)
        }
        self.stars.append(newStars)
    }
    
    private func defineTriangles(in star: Star) -> [Triangle] {
        guard let triangleZero = star.triangles.0, let triangleOne = star.triangles.1 else {
            return [star.triangles.0, star.triangles.1].flatMap {$0}
        }
        
        return [triangleZero, triangleOne]
    }
    
    private func buildStar(from triangle: Triangle) -> Star {
        let offset = triangle.height * Constants.offsetRatio
        let isUpsideDown = triangle.isUpsideDown
        let difference = isUpsideDown ? -offset : offset
        var newTriangle = triangle.reversed()
        newTriangle.vertices.0.y += difference
        newTriangle.vertices.1.y += difference
        newTriangle.vertices.2.y += difference
        return Star(triangles: (triangle, newTriangle))
    }
}

protocol ShapeGrammarBrainDelegate: AnyObject {
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didBuildShape shape: Shape)
}

