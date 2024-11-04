//
//  CGRect+Utils.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 04.11.2024.
//


import CoreGraphics

extension CGRect {
    public var mid: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
    
    public init(center: CGPoint, size: CGSize) {
        self.init(
            x: center.x - size.width / 2,
            y: center.y - size.height / 2,
            width: size.width,
            height: size.height
        )
    }
}
