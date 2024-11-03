//
//  Shapes.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 03.11.2024.
//

import SwiftUI

extension Path {
    
    static func star(x: CGFloat, y: CGFloat, radius: CGFloat, sides: Int, pointiness: CGFloat) -> Path {
        let adjustment = 360 / sides / 2
        var path = Path()
        let points = polygonPointArray(sides: sides, x: x, y: y, radius: radius)
        let cpg = points[0]
        let points2 = polygonPointArray(sides: sides, x: x, y: y, radius: radius * pointiness, adjustment: CGFloat(adjustment))
        
        var i = 0
        
        path.move(to: cpg)
        
        for p in points {
            path.addLine(to: points2[i])
            path.addLine(to: p)
            i += 1
        }
        path.closeSubpath()
        
        return path
    }
}

private func deg2rad(_ number: CGFloat)->CGFloat {
    return .pi * number / 180
}

private func polygonPointArray(sides: Int, x: CGFloat, y: CGFloat, radius: CGFloat, adjustment: CGFloat = 0) -> [CGPoint] {
    let angle = deg2rad(360 / CGFloat(sides))
    let cx = x
    let cy = y
    let r  = radius
    var i = sides
    var points = [CGPoint]()
    
    while points.count <= sides {
        let xpo = cx - r * cos(angle * CGFloat(i) + deg2rad(adjustment))
        let ypo = cy - r * sin(angle * CGFloat(i) + deg2rad(adjustment))
        points.append(CGPoint(x: xpo, y: ypo))
        i -= 1
    }
    
    return points
}
