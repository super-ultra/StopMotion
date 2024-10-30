//
//  GraphicsContext+Stroke.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 31.10.2024.
//

import SwiftUI

extension GraphicsContext {
    
    public mutating func draw(_ stroke: Stroke) {
        let shading: GraphicsContext.Shading
        
        switch stroke.tool {
        case .eraser:
            blendMode = .clear
            shading = .color(.white)
        case .pencil:
            blendMode = .normal
            shading = .color(stroke.color)
        }
        
        self.stroke(stroke.path, with: shading, lineWidth: 4)
    }
    
    public mutating func drawCursor(for tool: DrawingTool, color: Color, location: CGPoint) {
        let size = CGSize(width: 16, height: 16) // TODO: Fix 
        let rect = CGRect(origin: location, size: size)
            .offsetBy(dx: -size.width / 2, dy: -size.height / 2)
                    
        var path = Circle().path(in: rect)
                
        blendMode = .normal
        switch tool {
        case .eraser:
            stroke(path, with: .color(.gray), lineWidth: 1)
        case .pencil:
            fill(path, with: .color(color))
        }
    }
}
