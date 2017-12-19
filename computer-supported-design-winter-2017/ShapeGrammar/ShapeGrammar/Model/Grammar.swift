//
//  Grammar.swift
//  ShapeGrammar
//
//  Created by Witold Bobrowski on 19/12/2017.
//

import Foundation

struct Grammar<Element> {
    
    class Node {
        var element: Element?
        var nodes: [Location:Node] = [:]
        init(element: Element) {
            self.element = element
        }
    }
    
    var head: Node?
    
}

//MARK: - Public
extension Grammar {
    
    public func node(atPath locationPath: LocationPath) throws -> Node? {
        do {
            return try locationPath.reduce(head) { result, location in
                guard let node = result else { throw LocationPathError.PathOutOfRange }
                return node.nodes[location]
            }
        } catch {
            throw error
        }
    }
    
    public mutating func insert(_ element: Element, atPath locationPath: LocationPath) {
        guard let node = try? node(atPath: Array(locationPath.dropLast(1))), let tail = node else {
            self.head = Node(element: element)
            return
        }
        guard let location = locationPath.last else { return }
        tail.nodes[location] = Node(element: element)
    }
    
}
