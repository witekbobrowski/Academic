//
//  ShapeBuildingHelper.swift
//  ShapeGrammar
//
//  Created by Witek on 13/01/2018.
//

import UIKit

class ShapeBuildingHelper {
    
    public static let shared: ShapeBuildingHelper = ShapeBuildingHelper()
    
}

//MARK: - Public
extension ShapeBuildingHelper {
    
    public static func rebuildShapesFromGrammar(_ grammar: Grammar<Shape>, inRect rect: CGRect) -> UIBezierPath? {
        return nil
    }
    
    public static func build(from shape: Shape, at locations: [Location]) -> [Location:Shape] {
        var shapes: [Location:Shape] = [:]
        if let triangle = shape as? Triangle {
            shapes[.center] = Star(triangle: triangle)
        } else if let star = shape as? Star {
            let triangles = shared.getTriangles(in: star)
            locations.forEach { shapes[$0] = Star(triangle: triangles[$0]!) }
        }
        return shapes
    }
    
}

//MARK: - Private
extension ShapeBuildingHelper {
    
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
    
}
