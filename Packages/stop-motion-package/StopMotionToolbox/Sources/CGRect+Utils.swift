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
}
