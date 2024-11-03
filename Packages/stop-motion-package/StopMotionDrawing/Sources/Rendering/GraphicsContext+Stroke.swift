//
//  GraphicsContext+Stroke.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 31.10.2024.
//

import SwiftUI

extension GraphicsContext {
    
    public mutating func draw(_ layer: Layer) {
        for stroke in layer.strokes {
            draw(stroke)
        }
    }
    
    public mutating func draw(_ stroke: Stroke) {
//        withCGContext { context in
//            context.draw(stroke)
//        }
        let shading: GraphicsContext.Shading
        
        switch stroke.tool.type {
        case .eraser:
            blendMode = .clear
            shading = .color(.white)
        case .brush:
            blendMode = .normal
            shading = .color(stroke.color)
        }
        
        let style = StrokeStyle(lineWidth: stroke.tool.size, lineCap: .round, lineJoin: .round)
        
        self.stroke(stroke.path, with: shading, style: style)
    }
    
    public mutating func drawCursor(for tool: DrawingTool, color: Color, location: CGPoint) {
        let size = CGSize(width: tool.size, height: tool.size)
        let rect = CGRect(origin: location, size: size)
            .offsetBy(dx: -size.width / 2, dy: -size.height / 2)
                    
        var path = Circle().path(in: rect)
                
        blendMode = .normal
        switch tool.type {
        case .eraser:
            stroke(path, with: .color(.gray), lineWidth: 1)
        case .brush:
            fill(path, with: .color(color))
        }
    }
}
