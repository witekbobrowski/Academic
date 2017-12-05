//
//  ShapeGrammarBrain.swift
//  ShapeGrammar
//
//  Created by Witek on 20/11/2017.
//

import CoreGraphics

enum Location: Int {
    case north = 0
    case northEast = 1
    case southEast = 2
    case south = 3
    case southWest = 4
    case northWest = 5
    
    case center = 6
}

class ShapeGrammarBrain {
    
    struct Item {
        var shape: Shape
        var location: Location
        var items: [Location:Item]
    }
    
    private var items: [Location:Item] = [:]
    public weak var delegate: ShapeGrammarBrainDelegate?
    
}

//MARK: - Public
extension ShapeGrammarBrain {
    
    public var isEmpty: Bool {
        return items.isEmpty
    }
    
    public func clear() {
        items = [:]
    }
    
    public func set(_ shape: Shape, at location: Location) {
        items = [location:Item(shape: shape, location: location, items: [:])]
        delegate?.shapeGrammarBrain(self, didBuildShape: shape)
    }
    
    public func addLayer(at locations: [Location]) {
        
    }
    
    public func random() {
        var directions: [[Location]] = []
        for _ in 0...3 {
            var locations: Set<Location> = []
            for _ in 0...Int(arc4random_uniform(UInt32(6))) {
                locations.insert(Location(rawValue: Int(arc4random_uniform(UInt32(6))))!)
            }
            directions.append(Array(locations))
        }
        guard let item = items[.center] else { return }
        var current: [Item] = [item]
        for direction in directions {
            var newItems: [Item] = []
            current.forEach { newItems.append(contentsOf: build(from: $0, at: direction).values)}
            current = newItems
        }
    }
    
}

//MARK: - Private
extension ShapeGrammarBrain {
    
    private func build(from item: Item, at locations: [Location]) -> [Location:Item] {
        var items: [Location:Item] = [:]
        if let triangle = item.shape as? Triangle {
            let star = Star(triangle: triangle)
            items[.center] = Item(shape: star, location: item.location, items: [:])
            delegate?.shapeGrammarBrain(self, didBuildShape: star)
        } else if let star = item.shape as? Star {
            let triangles = getTriangles(in: star)
            locations.forEach {
                let star = Star(triangle: triangles[$0]!)
                items[$0] = Item(shape: star, location: $0, items: [:])
                delegate?.shapeGrammarBrain(self, didBuildShape: star.triangles.1)
            }
        }
        return items
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

protocol ShapeGrammarBrainDelegate: AnyObject {
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didBuildShape shape: Shape)
}

