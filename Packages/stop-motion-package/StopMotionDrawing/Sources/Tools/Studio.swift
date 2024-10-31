//
//  Studio.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 30.10.2024.
//

import SwiftUI

@MainActor
public protocol Studio: AnyObject, Observable {
    var layer: Layer { get }
    var tool: DrawingTool { get set }
    var toolColor: Color { get set }
    
    var isUndoAvailable: Bool { get }
    var isRedoAvailable: Bool { get }
    
    func drag(_ point: CGPoint)
    func endDragging(_ point: CGPoint)
    func undo()
    func redo()
}

@MainActor
@Observable // TODO: Think about it
public final class StudioImpl: Studio {
    
    public init(layer: Layer = Layer(), tool: DrawingTool, color: Color) {
        self.layer = layer
        self.tool = tool
        self.toolColor = color
    }
    
    // MARK: - Studio
    
    public private(set) var layer: Layer
    
    public var tool: DrawingTool
    
    public var toolColor: Color
    
    public var isUndoAvailable: Bool { !layer.strokes.isEmpty }
    
    public var isRedoAvailable: Bool { !undoStrokes.isEmpty }
    
    public func drag(_ point: CGPoint) {
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
    
    public func endDragging(_ point: CGPoint) {
        isDragging = false
        
        guard !layer.strokes.isEmpty else {
            assertionFailure()
            return
        }
        
        layer.strokes[layer.strokes.count - 1].path.addLine(to: point)
    }
    
    public func undo() {
        guard !layer.strokes.isEmpty else { return }
        
        undoStrokes.append(layer.strokes.removeLast())
    }
    
    public func redo() {
        guard !undoStrokes.isEmpty else { return }
        
        layer.strokes.append(undoStrokes.removeLast())
    }
    
    // MARK: - Private
    
    private var isDragging = false
    
    private var undoStrokes: [Stroke] = []
}
