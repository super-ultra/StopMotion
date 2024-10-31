//
//  StudioImpl.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 31.10.2024.
//

import SwiftUI

@MainActor
@Observable // TODO: Think about it
public final class StudioImpl: Studio {
    
    public init(tool: DrawingTool, color: Color) {
        self.layerManagers = [LayerManager()]
        self.tool = tool
        self.toolColor = color
    }
    
    // MARK: - Studio
    
    public var layers: [Layer] {
        layerManagers.map { $0.layer }
    }
    
    public var currentLayer: Layer {
        currentLayerManager.layer
    }
    
    public var tool: DrawingTool
    
    public var toolColor: Color
    
    public var isUndoAvailable: Bool {
        currentLayerManager.isUndoAvailable
    }
    
    public var isRedoAvailable: Bool {
        currentLayerManager.isRedoAvailable
    }
    
    public func drag(_ point: CGPoint) {
        currentLayerManager.drag(point, tool: tool, toolColor: toolColor)
    }
    
    public func endDragging(_ point: CGPoint) {
        currentLayerManager.endDragging(point)
    }
    
    public func undo() {
        currentLayerManager.undo()
    }
    
    public func redo() {
        currentLayerManager.redo()
    }
    
    public func makeNewLayer() {
        layerManagers.append(LayerManager())
    }
    
    public func deleteCurrentLayer() {
        layerManagers.removeLast()
        
        if layerManagers.isEmpty {
            layerManagers = [LayerManager()]
        }
    }
    
    // MARK: - Private
    
    private var isDragging = false
    
    private var layerManagers: [LayerManager]
    
    private var currentLayerManager: LayerManager {
        guard let topLayerManager = layerManagers.last else {
            assertionFailure()
            
            let newLayerManager = LayerManager()
            layerManagers = [newLayerManager]
            return newLayerManager
        }
        
        return topLayerManager
    }
}
