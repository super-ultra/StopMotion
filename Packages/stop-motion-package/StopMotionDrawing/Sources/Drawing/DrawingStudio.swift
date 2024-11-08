//
//  Studio.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 30.10.2024.
//

import SwiftUI

@MainActor
public protocol DrawingStudio: AnyObject, Observable {
    /// Current layer always exists
    var currentLayer: Layer { get }
    var currentLayerIndex: Int { get }
    var layersCount: Int { get }
    var tool: DrawingTool { get set }
    var toolColor: CGColor { get set }
    var toolScale: CGFloat { get set }
    var canvasSize: CGSize { get set }
    
    var isUndoAvailable: Bool { get }
    var isRedoAvailable: Bool { get }
    
    var isLayersGenerating: Bool { get }
    
    func layer(at index: Int) -> Layer
    func getAllLayers() -> [Layer]
    func drag(_ point: CGPoint)
    func endDragging(_ point: CGPoint)
    func tap(_ point: CGPoint)
    func addStoke(_ stroke: Stroke)
    func undo()
    func redo()
    
    func makeNewLayer()
    func duplicateLayer()
    func generateLayers(count: Int)
    func deleteCurrentLayer()
    func deleteAllLayers()
    func selectLayer(at index: Int)
}
