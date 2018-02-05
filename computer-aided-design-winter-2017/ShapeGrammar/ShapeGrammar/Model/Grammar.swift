//
//  Grammar.swift
//  ShapeGrammar
//
//  Created by Witold Bobrowski on 19/12/2017.
//

import Foundation

class Grammar<Element> {

    class Node {
        var element: Element
        var nodes: [Location:Node] = [:]
        init(element: Element) {
            self.element = element
        }
    }
    
    var head: Node
    
    init(element: Element) {
        self.head = Node(element: element)
    }
    
}

//MARK: - Public
extension Grammar {
    
    public func node(atPath locationPath: LocationPath) -> Node? {
        return locationPath.reduce(head) { (result, location) -> Node? in
            guard let node = result?.nodes[location] else { return nil }
            return node
        }
    }
    
    public func insert(_ element: Element, atPath locationPath: LocationPath) {
        guard let tail = node(atPath: Array(locationPath.dropLast(1))) else {
            self.head = Node(element: element)
            return
        }
        guard let location = locationPath.last else { return }
        tail.nodes[location] = Node(element: element)
    }
    
    public func getPaths() -> [LocationPath] {
        return head.nodes.reduce([]) { $0 + extractPaths(fromNode: $1.value, at: $1.key) }
    }
    
}

//MARK: - Private
extension Grammar {
    
    private func extractPaths(fromNode node: Node, at location: Location) -> [LocationPath] {
        guard !node.nodes.isEmpty else { return [[location]] }
        var paths: [LocationPath] = []
        node.nodes.forEach { paths.append(contentsOf: extractPaths(fromNode: $0.value, at: $0.key))}
        return paths.map { [location] + $0 }
    }
    
}
