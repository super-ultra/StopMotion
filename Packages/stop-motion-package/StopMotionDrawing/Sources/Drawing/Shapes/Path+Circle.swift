//
//  Path+Circle.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 04.11.2024.
//


import SwiftUI

extension Path {
    
    public init(circumscribedCircleInRect rect:CGRect) {
        self.init()
        
        let halfWidth = rect.width / 2
        let halfHeight = rect.height / 2
        let radius = sqrt(halfWidth * halfWidth + halfHeight * halfHeight)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        self.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .degrees(360), clockwise: true)
    }
    
}
