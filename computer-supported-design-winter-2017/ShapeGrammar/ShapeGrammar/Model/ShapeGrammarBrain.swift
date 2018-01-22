//
//  ShapeGrammarBrain.swift
//  ShapeGrammar
//
//  Created by Witek on 20/11/2017.
//

import CoreGraphics

protocol ShapeGrammarBrainDelegate: AnyObject {
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didFinishBuildingGrammar grammar: ShapeGrammar)
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didFinishGradingSamples samples: [(ShapeGrammar, Int)])
    func rectForDrawing(_ shapeGrammarBraint: ShapeGrammarBrain) -> CGRect?
}

typealias ShapeGrammar = Grammar<Shape>
typealias Node = ShapeGrammar.Node

class ShapeGrammarBrain {
    
    private enum Constants {
        static var initialGenerationCount: Int { return Int(arc4random_uniform(16)) + 16 }
    }
    
    private var grammar: ShapeGrammar? { didSet { gatherBestSamples() } }
    
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
    
    public func evolve(withGrammars grammars: [ShapeGrammar]) {
        guard let grammar = grammar, !grammars.isEmpty else { return }
        let paths = grammar.getPaths()
        if paths.isEmpty {
            applySample(at: grammar.head, sample: grammars[Int(arc4random_uniform(UInt32(grammars.count)))].head)
        } else {
            for path in paths {
                guard path.count < 4, let node = grammar.node(atPath: path) else { continue }
                applySample(at: node, sample: grammars[Int(arc4random_uniform(UInt32(grammars.count)))].head)
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
        ShapeBuildingHelper.shared.build(from: node.element, at: Array(locations)).forEach { (location, shape) in
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
        for _ in 0..<Constants.initialGenerationCount {
            let grammar = ShapeGrammar(element: grammar.head.element)
            random(grammar.head, maxDepth: Int(arc4random_uniform(UInt32(4))) + 1)
            samples.append((grammar: grammar, grade: ShapeGradingHelper.shared.getGrade(fromGrammar: grammar.head)))
        }
        samples.sort { $0.grade > $1.grade }
        delegate?.shapeGrammarBrain(self, didFinishGradingSamples: samples)
    }
    
    private func applySample(at node: Node, sample: Node) {
        addSamples(toNode: node, samples: sample.nodes)
        for location in node.nodes.keys {
            guard let node = node.nodes[location], let sample = sample.nodes[location] else { continue }
            applySample(at: node, sample: sample)
        }
    }
    
    private func addSamples(toNode node: Node, samples: [Location:Node]) {
        let shapes = ShapeBuildingHelper.shared.build(from: node.element, at: Array<Location>(samples.keys))
        shapes.forEach { node.nodes[$0.key] = Node(element: $0.value) }
    }
    
}

