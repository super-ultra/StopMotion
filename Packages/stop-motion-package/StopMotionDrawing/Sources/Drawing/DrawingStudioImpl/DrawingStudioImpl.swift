//
//  StudioImpl.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 31.10.2024.
//

import SwiftUI

@MainActor
@Observable
public final class DrawingStudioImpl: DrawingStudio {
    
    public init(tool: DrawingTool, color: CGColor) {
        self.layerManagers = [LayerManager()]
        self.currentLayerIndex = 0
        self.tool = tool
        self.toolColor = color
    }
    
    // MARK: - Studio
    
    public private(set) var currentLayerIndex: Int
    
    public var currentLayer: Layer {
        currentLayerManager.layer
    }

    public var layersCount: Int {
        layerManagers.count
    }
    
    public var tool: DrawingTool
    
    public var toolColor: CGColor
    
    public var isUndoAvailable: Bool {
        currentLayerManager.isUndoAvailable
    }
    
    public var isRedoAvailable: Bool {
        currentLayerManager.isRedoAvailable
    }
    
    public func layer(at index: Int) -> Layer {
        layerManagers[index].layer
    }
    
    public func getAllLayers() -> [Layer] {
        layerManagers.map { $0.layer }
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
        layerManagers.insert(LayerManager(), at: currentLayerIndex + 1)
        currentLayerIndex += 1
    }
    
    public func duplicateLayer() {
        layerManagers.insert(LayerManager(layer: currentLayer), at: currentLayerIndex + 1)
        currentLayerIndex += 1
    }
    
    public func generateLayers(count: Int) {
        let generator = LayerGenerator()
        
        let currentIndex = currentLayerIndex
        let fromIndex: Int

        var newManagers = layerManagers
        if newManagers[currentIndex].layer.strokes.isEmpty {
            newManagers.remove(at: currentIndex)
            fromIndex = max(currentIndex - 1, 0)
        } else {
            fromIndex = currentIndex
        }
        
        let generatedManagers = generator
            .generateLayers(basedOn: newManagers.map { $0.layer }, fromIndex: fromIndex, count: count)
            .map { LayerManager(layer: $0) }
        
        if !generatedManagers.isEmpty {
            newManagers.insert(contentsOf: generatedManagers, at: fromIndex)
            layerManagers = newManagers
            currentLayerIndex = currentLayerIndex + count
        }
    }
    
    public func deleteCurrentLayer() {
        layerManagers.remove(at: currentLayerIndex)
        currentLayerIndex -= 1
        
        if layerManagers.isEmpty {
            resetState()
        }
    }
    
    public func deleteAllLayers() {
        resetState()
    }
    
    public func selectLayer(at index: Int) {
        guard index >= 0, index < layerManagers.count else {
            assertionFailure()
            return
        }
        
        currentLayerIndex = index
    }
    
    // MARK: - Private
    
    private var isDragging = false
    
    private var layerManagers: [LayerManager]
    
    private var currentLayerManager: LayerManager {
        return layerManagers[currentLayerIndex]
    }
    
    private func resetState() {
        layerManagers = [LayerManager()]
        currentLayerIndex = 0
    }
}
