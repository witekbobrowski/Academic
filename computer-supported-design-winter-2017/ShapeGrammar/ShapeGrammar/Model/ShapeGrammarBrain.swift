//
//  ShapeGrammarBrain.swift
//  ShapeGrammar
//
//  Created by Witek on 20/11/2017.
//

import CoreGraphics

protocol ShapeGrammarBrainDelegate: AnyObject {
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didFinishBuildingGrammar grammar: Grammar<Shape>)
    func rectForDrawing(_ shapeGrammarBraint: ShapeGrammarBrain) -> CGRect?
}

class ShapeGrammarBrain {
    
    typealias ShapeGrammar = Grammar<Shape>
    typealias Node = ShapeGrammar.Node
    
    private var grammar: Grammar<Shape>? { didSet { gatherBestSamples() } }
    private var bestSamples: [Node] = []
    
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
    
    public func setup() {
        guard let rect = delegate?.rectForDrawing(self) else { return }
        let grammar = ShapeGrammar(element: Star(rect: rect))
        self.grammar = grammar
        delegate?.shapeGrammarBrain(self, didFinishBuildingGrammar: grammar)
    }
    
    public func evolve() {
        guard let grammar = grammar else { return }
        let paths = pickPaths(inGrammar: grammar)
        if paths.isEmpty {
            applySample(at: grammar.head, sample: bestSamples[Int(arc4random_uniform(UInt32(3)))])
        } else {
            for path in paths {
                guard path.count < 3, let node = try? grammar.node(atPath: path) else { continue }
                applySample(at: node, sample: bestSamples[Int(arc4random_uniform(UInt32(3)))])
            }
        }
        delegate?.shapeGrammarBrain(self, didFinishBuildingGrammar: grammar)
    }
    
    public func random() {
        guard let rect = delegate?.rectForDrawing(self) else { return }
        let grammar = ShapeGrammar(element: Star(rect: rect))
        random(grammar.head, maxDepth: Int(arc4random_uniform(UInt32(4))) + 2)
        self.grammar = grammar
        delegate?.shapeGrammarBrain(self, didFinishBuildingGrammar: grammar)
    }
    
}

//MARK: - Private - Building
extension ShapeGrammarBrain {
    
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
            shapes[.center] = Star(triangle: triangle)
        } else if let star = shape as? Star {
            let triangles = getTriangles(in: star)
            locations.forEach { shapes[$0] = Star(triangle: triangles[$0]!) }
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
        triangles[.center] = star.triangles.0
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

//MARK: - Private - Evolution
extension ShapeGrammarBrain {
    
    private func gatherBestSamples() {
        guard let grammar = grammar else { return }
        var samples: [(grammar: ShapeGrammar, grade: Int)] = []
        for _ in 0...50 {
            let grammar = ShapeGrammar(element: grammar.head.element)
            random(grammar.head, maxDepth: Int(arc4random_uniform(UInt32(4))) + 1)
            samples.append((grammar: grammar, grade: ShapeGradingHelper.shared.getGrade(fromGrammar: grammar.head)))
        }
        samples.sort { $0.grade < $1.grade }
        bestSamples = samples.suffix(3).map { $0.grammar.head }
    }
    
    private func pickPaths(inGrammar grammar: ShapeGrammar) -> [LocationPath] {
        var paths: [LocationPath] = grammar.getPaths()
        return paths
    }
    
    private func applySample(at node: Node, sample: Node) {
        addSamples(toNode: node, samples: sample.nodes)
        for location in node.nodes.keys {
            guard let node = node.nodes[location], let sample = sample.nodes[location] else { continue }
            applySample(at: node, sample: sample)
        }
    }
    
    private func addSamples(toNode node: Node, samples: [Location:Node]) {
        let shapes = build(from: node.element, at: Array<Location>(samples.keys))
        shapes.forEach { node.nodes[$0.key] = Node(element: $0.value) }
    }
    
}
