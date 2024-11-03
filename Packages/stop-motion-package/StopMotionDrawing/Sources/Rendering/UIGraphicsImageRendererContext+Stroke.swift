//
//  UIGraphicsImageRendererContext+Stroke.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 03.11.2024.
//

import CoreGraphics
import UIKit

extension CGContext {
    
    public func draw(_ layer: Layer, background: CGImage? = nil) {
        if let background {
            draw(background, in: CGRect(x: 0, y: 0, width: background.width, height: background.height))
        }
        for stroke in layer.strokes {
            draw(stroke)
        }
    }
    
    public func draw(_ stroke: Stroke) {
        switch stroke.tool.type {
        case .eraser:
            setBlendMode(.clear)
            setStrokeColor(CGColor(red: 1, green: 1, blue: 1, alpha: 1))
        case .pencil:
            setBlendMode(.normal)
            setStrokeColor(UIColor(stroke.color).cgColor)
        }
        
        setLineCap(.round)
        setLineJoin(.round)
        setLineWidth(stroke.tool.size)
        addPath(stroke.path.cgPath)
        drawPath(using: .stroke)
    }
}
