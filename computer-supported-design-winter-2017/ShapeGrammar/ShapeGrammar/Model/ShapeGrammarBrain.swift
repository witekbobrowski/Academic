//
//  ShapeGrammarBrain.swift
//  ShapeGrammar
//
//  Created by Witek on 20/11/2017.
//

import CoreGraphics

protocol ShapeGrammarBrainDelegate: AnyObject {
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didBuildShape shape: Shape)
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didFinishCalculatingScore score: Int)
    func rectForDrawing(_ shapeGrammarBraint: ShapeGrammarBrain) -> CGRect
}

class ShapeGrammarBrain {
    
    typealias Node = Grammar<Shape>.Node
    
    private var grammar: Grammar<Shape>?
    
    public weak var delegate: ShapeGrammarBrainDelegate?

}

//MARK: - Public
extension ShapeGrammarBrain {
    
    public var isEmpty: Bool {
        return grammar == nil
    }
    
    public func clear() {
        grammar = nil
    }
    
    public func addLayer() {
        
    }
    
    public func random() {
        grammar = Grammar<Shape>(element: setup(Triangle(rect: delegate?.rectForDrawing(self) ?? .zero)))
        guard let head = grammar?.head else { return }
        random(head, maxDepth: Int(arc4random_uniform(UInt32(4))) + 1)
        delegate?.shapeGrammarBrain(self, didFinishCalculatingScore: ShapeGradingHelper.shared.getGrade(fromGrammar: head))
    }
    
}

//MARK: - Private
extension ShapeGrammarBrain {
    
    private func setup(_ shape: Shape) -> Shape {
        delegate?.shapeGrammarBrain(self, didBuildShape: shape)
        return shape
    }
    
    private func random(_ node: Node, maxDepth depth: Int) {
        guard depth > 0 else { return }
        var locations: Set<Location> = []
        for _ in 0...Int(arc4random_uniform(UInt32(6))) {
            locations.insert(Location(rawValue: Int(arc4random_uniform(UInt32(6))))!)
        }
        build(from: node.element, at: Array(locations)).forEach { (location, shape) in
            let new = Node(element: shape)
            node.nodes[location] = new
            random(new, maxDepth: depth-1)
        }
    }
    
    private func build(from shape: Shape, at locations: [Location]) -> [Location:Shape] {
        var shapes: [Location:Shape] = [:]
        if let triangle = shape as? Triangle {
            let star = Star(triangle: triangle)
            shapes[.center] = star
            delegate?.shapeGrammarBrain(self, didBuildShape: star)
        } else if let star = shape as? Star {
            let triangles = getTriangles(in: star)
            locations.forEach {
                let star = Star(triangle: triangles[$0]!)
                shapes[$0] = star
                delegate?.shapeGrammarBrain(self, didBuildShape: star.triangles.1)
            }
        }
        return shapes
    }
    
    private func getTriangles(in star: Star) -> [Location:Triangle] {
        guard star.triangles.0.height > 3 && star.triangles.1.height > 3 else { return [:] }
        var triangles: [Location:Triangle] = [:]
        let center = star.center!
        let size = star.triangles.1.size/3
        let vertices = getVertices(in: star)
        let height = (center.y - vertices[.north]!.y)/2
        let internalNW = CGPoint(x: center.x - size/2, y: center.y - height)
        let internalNE = CGPoint(x: center.x + size/2, y: center.y - height)
        let internalE = CGPoint(x: center.x + size, y: center.y)
        let internalSE = CGPoint(x: center.x + size/2, y: center.y + height)
        let internalSW = CGPoint(x: center.x - size/2, y: center.y + height)
        let internalW = CGPoint(x: center.x - size, y: center.y)
        triangles[.north] = Triangle(rect: star.rect, vertices:
            (internalNW, vertices[.north]!, internalNE))
        triangles[.northEast] = Triangle(rect: star.rect, vertices:
            (internalNE, internalE, vertices[.northEast]!))
        triangles[.southEast] = Triangle(rect: star.rect, vertices:
            (internalSE, internalE, vertices[.southEast]!))
        triangles[.south] = Triangle(rect: star.rect, vertices:
            (internalSW, vertices[.south]!, internalSE))
        triangles[.southWest] = Triangle(rect: star.rect, vertices:
            (vertices[.southWest]!, internalW, internalSW))
        triangles[.northWest] = Triangle(rect: star.rect, vertices:
            (vertices[.northWest]!, internalW, internalNW))
        return triangles
    }
    
    private func getVertices(in star: Star) -> [Location:CGPoint] {
        var vertices: [Location:CGPoint] = [:]
        var sortedVertices = [star.triangles.0.vertices.0, star.triangles.0.vertices.1, star.triangles.0.vertices.2,
                              star.triangles.1.vertices.0, star.triangles.1.vertices.1, star.triangles.1.vertices.2].sorted {$0.y < $1.y}
        vertices[.north] = sortedVertices.first
        vertices[.south] = sortedVertices.last
        vertices[.northWest] = sortedVertices[1].x < sortedVertices[2].x ? sortedVertices[1] : sortedVertices[2]
        vertices[.northEast] = sortedVertices[1].x < sortedVertices[2].x ? sortedVertices[2] : sortedVertices[1]
        vertices[.southWest] = sortedVertices[3].x < sortedVertices[4].x ? sortedVertices[3] : sortedVertices[4]
        vertices[.southEast] = sortedVertices[3].x < sortedVertices[4].x ? sortedVertices[4] : sortedVertices[3]
        return vertices
    }
    
}
