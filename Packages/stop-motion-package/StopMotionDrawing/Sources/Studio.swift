//
//  Studio.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 30.10.2024.
//

import SwiftUI

@MainActor
public final class Studio {
    public private(set) var layer: Layer
    public var tool: DrawingTool
    public var color: Color
    
    public init(layer: Layer = Layer(), tool: DrawingTool, color: Color) {
        self.layer = layer
        self.tool = tool
        self.color = color
    }
    
    public func drag(_ point: CGPoint) {
        if isDragging {
            guard !layer.strokes.isEmpty else {
                assertionFailure()
                return
            }
            
            layer.strokes[layer.strokes.count - 1].path.addLine(to: point)
        } else {
            isDragging = true
            
            let path = Path {
                $0.move(to: point)
            }
            let newStroke = Stroke(path: path, color: color, tool: tool)
            layer.strokes.append(newStroke)
        }
    }
    
    public func endDragging(_ point: CGPoint) {
        isDragging = false
        
        guard !layer.strokes.isEmpty else {
            assertionFailure()
            return
        }
        
        layer.strokes[layer.strokes.count - 1].path.addLine(to: point)
    }
    
    // MARK: - Private
    
    private var isDragging = false
}
