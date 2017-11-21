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
    
    init() {
        self.buildShapes()
    }
    
}

//MARK: - Configuration
extension ShapeGrammarBrain {
    
    private func buildShapes() {
        guard let stars = stars.first else {
            return
        }
        var newStars: [Star] = []
        for star in stars {
            for triangle in defineTriangles(in: star) {
                let star = buildStar(from: triangle)
                newStars.append(star)
                delegate?.shapeGrammarBrain(self, didBuildShape: star)
            }
        }
        self.stars.append(newStars)
    }
    
    private func defineTriangles(in star: Star) -> [Triangle] {
        return []
    }
    
    private func buildStar(from triangle: Triangle) -> Star {
        let size = triangle.size
        let height = (size * sqrt(3))/2
        var newTriangle = Triangle(rect: triangle.rect)
        return Star(triangles: (triangle, newTriangle))
    }
}

protocol ShapeGrammarBrainDelegate: AnyObject {
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didBuildShape shape: Shape)
}

