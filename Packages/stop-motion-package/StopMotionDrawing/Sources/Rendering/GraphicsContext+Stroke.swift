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
    
    public mutating func drawCursor(for tool: DrawingTool, color: Color, location: CGPoint, scale: CGFloat) {
        guard scale > 0 else {
            assertionFailure("Invalid scale: \(scale)")
            return
        }
        
        let size = CGSize(width: tool.size / scale, height: tool.size / scale)
        let rect = CGRect(origin: location, size: size)
            .offsetBy(dx: -size.width / 2, dy: -size.height / 2)
                    
        let path = Circle().path(in: rect)
                
        blendMode = .normal
        switch tool.type {
        case .eraser:
            stroke(path, with: .color(.black), lineWidth: 2 / scale)
        case .brush, .pencil:
            fill(path, with: .color(color))
        }
    }
    
    public mutating func drawDashedBoundingRect(for stroke: Stroke, color: Color, lineWidth: CGFloat) {
        let inset = stroke.tool.size / 2 + 2
        let rect = stroke.path.boundingRect.insetBy(dx: -inset, dy: -inset)
        let path = Path(roundedRect: rect, cornerRadius: 8)
        
        withTransform(stroke.transform) {
            $0.stroke(
                path,
                with: .color(color),
                style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round, dash: [2, 8])
            )
        }
    }
    
    public mutating func withTransform(_ transform: CGAffineTransform, action: (inout GraphicsContext) -> Void) {
        let previousTransform = self.transform
        
        concatenate(transform)
        action(&self)
        self.transform = previousTransform
    }
    
}
