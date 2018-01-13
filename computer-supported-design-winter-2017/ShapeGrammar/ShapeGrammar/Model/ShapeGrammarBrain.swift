//
//  ShapeGrammarBrain.swift
//  ShapeGrammar
//
//  Created by Witek on 20/11/2017.
//

import CoreGraphics

protocol ShapeGrammarBrainDelegate: AnyObject {
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didFinishBuildingGrammar grammar: Grammar<Shape>)
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didFinishGradingSamples samples: [(Grammar<Shape>, Int)])
    func rectForDrawing(_ shapeGrammarBraint: ShapeGrammarBrain) -> CGRect?
}

class ShapeGrammarBrain {
    
    typealias ShapeGrammar = Grammar<Shape>
    typealias Node = ShapeGrammar.Node
    
    private enum Constants {
        static let bestSamplesCount: Int = 2
        static let totalSampleCount: Int = 100
    }
    
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
        let paths = grammar.getPaths()
        if paths.isEmpty {
            applySample(at: grammar.head, sample: bestSamples[Int(arc4random_uniform(UInt32(Constants.bestSamplesCount)))])
        } else {
            for path in paths {
                guard path.count < 4, let node = try? grammar.node(atPath: path) else { continue }
                applySample(at: node, sample: bestSamples[Int(arc4random_uniform(UInt32(Constants.bestSamplesCount)))])
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

//MARK: - Private - Random
extension ShapeGrammarBrain {
    
    private func random(_ node: Node, maxDepth depth: Int) {
        guard depth > 0 else { return }
        var locations: Set<Location> = []
        for _ in 0...Int(arc4random_uniform(UInt32(6))) {
            locations.insert(Location(rawValue: Int(arc4random_uniform(UInt32(6))))!)
        }
        ShapeBuildingHelper.build(from: node.element, at: Array(locations)).forEach { (location, shape) in
            let new = Node(element: shape)
            node.nodes[location] = new
            random(new, maxDepth: depth-1)
        }
    }
    
}

//MARK: - Private - Evolution
extension ShapeGrammarBrain {
    
    private func gatherBestSamples() {
        guard let grammar = grammar else { return }
        var samples: [(grammar: ShapeGrammar, grade: Int)] = []
        for _ in 0..<Constants.totalSampleCount {
            let grammar = ShapeGrammar(element: grammar.head.element)
            random(grammar.head, maxDepth: Int(arc4random_uniform(UInt32(4))) + 1)
            samples.append((grammar: grammar, grade: ShapeGradingHelper.shared.getGrade(fromGrammar: grammar.head)))
        }
        samples.sort { $0.grade > $1.grade }
        delegate?.shapeGrammarBrain(self, didFinishGradingSamples: samples)
        bestSamples = Array(samples.prefix(Constants.bestSamplesCount)).map { $0.grammar.head }
    }
    
    private func applySample(at node: Node, sample: Node) {
        addSamples(toNode: node, samples: sample.nodes)
        for location in node.nodes.keys {
            guard let node = node.nodes[location], let sample = sample.nodes[location] else { continue }
            applySample(at: node, sample: sample)
        }
    }
    
    private func addSamples(toNode node: Node, samples: [Location:Node]) {
        let shapes = ShapeBuildingHelper.build(from: node.element, at: Array<Location>(samples.keys))
        shapes.forEach { node.nodes[$0.key] = Node(element: $0.value) }
    }
    
}
