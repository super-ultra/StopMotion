//
//  LayerManager.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 31.10.2024.
//

import SwiftUI

@Observable
final class LayerManager {
    
    init(layer: Layer = Layer()) {
        self.layer = layer
    }
    
    private(set) var layer: Layer
    
    var isUndoAvailable: Bool { !layer.strokes.isEmpty }
    
    var isRedoAvailable: Bool { !undoStrokes.isEmpty }
    
    func drag(_ point: CGPoint, tool: DrawingTool, toolColor: CGColor) {
        undoStrokes.removeAll()
        
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
            let newStroke = Stroke(path: path, color: toolColor, tool: tool)
            layer.strokes.append(newStroke)
        }
    }
    
    func endDragging(_ point: CGPoint) {
        isDragging = false
        
        guard !layer.strokes.isEmpty else {
            assertionFailure()
            return
        }
        
        layer.strokes[layer.strokes.count - 1].path.addLine(to: point)
    }
    
    func undo() {
        guard !layer.strokes.isEmpty else { return }
        
        undoStrokes.append(layer.strokes.removeLast())
    }
    
    func redo() {
        guard !undoStrokes.isEmpty else { return }
        
        layer.strokes.append(undoStrokes.removeLast())
    }
    
    // MARK: - Private
    
    private var isDragging = false
    
    private var undoStrokes: [Stroke] = []
}
