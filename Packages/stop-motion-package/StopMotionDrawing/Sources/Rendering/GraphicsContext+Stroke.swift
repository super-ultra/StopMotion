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
        withCGContext { context in
            context.draw(stroke)
        }
    }
    
    public mutating func drawCursor(for tool: DrawingTool, color: Color, location: CGPoint) {
        let size = CGSize(width: tool.size, height: tool.size)
        let rect = CGRect(origin: location, size: size)
            .offsetBy(dx: -size.width / 2, dy: -size.height / 2)
                    
        let path = Circle().path(in: rect)
                
        blendMode = .normal
        switch tool.type {
        case .eraser:
            stroke(path, with: .color(.black), lineWidth: 2)
        case .brush, .pencil:
            fill(path, with: .color(color))
        }
    }
    
    public mutating func drawDashedBoundingRect(for stroke: Stroke, color: Color, lineWidth: CGFloat) {
        let rect = stroke.path.boundingRect.insetBy(dx: -8, dy: -8)
        let path = Path(roundedRect: rect, cornerRadius: 8)
        
        self.stroke(path, with: .color(color), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round, dash: [4]))
        
    }
}
