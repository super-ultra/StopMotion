//
//  GraphicsContext+Stroke.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 31.10.2024.
//

import SwiftUI

import StopMotionToolbox


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
    
    public mutating func drawBoundingRect(
        for stroke: Stroke,
        color: Color,
        lineWidth: CGFloat,
        dash: [CGFloat] = [CGFloat](),
        dashPhase: CGFloat = 0
    ) {
        let inset = stroke.tool.size / 2
        let rect = stroke.path.boundingRect.insetBy(dx: -inset, dy: -inset)
        let path = Path(rect)
        
        withTransform(stroke.transform) {
            $0.stroke(
                path,
                with: .color(color),
                style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round, dash: dash, dashPhase: dashPhase)
            )
            
            for x in [rect.minX, rect.midX, rect.maxX] {
                for y in [rect.minY, rect.midY, rect.maxY] {
                    if x == rect.midX && y == rect.midY {
                        continue
                    }
                    
                    let square = Path(CGRect(center: CGPoint(x: x, y: y), size: CGSize(width: 4, height: 4)))
                    
                    $0.fill(square, with: .color(.white))
                    $0.stroke(square, with: .color(.black), lineWidth: 1)
                }
            }
        }
    }
    
    public mutating func withTransform(_ transform: CGAffineTransform, action: (inout GraphicsContext) -> Void) {
        let previousTransform = self.transform
        
        concatenate(transform)
        action(&self)
        self.transform = previousTransform
    }
    
}


