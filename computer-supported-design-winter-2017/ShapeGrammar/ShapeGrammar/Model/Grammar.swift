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
    
    public func node(atPath locationPath: LocationPath) throws -> Node {
        do {
            return try locationPath.reduce(head) { result, location in
                guard let node = result.nodes[location] else { throw LocationPathError.PathOutOfRange }
                return node
            }
        } catch {
            throw error
        }
    }
    
    public func insert(_ element: Element, atPath locationPath: LocationPath) {
        guard let tail = try? node(atPath: Array(locationPath.dropLast(1))) else {
            self.head = Node(element: element)
            return
        }
        guard let location = locationPath.last else { return }
        tail.nodes[location] = Node(element: element)
    }
    
}
