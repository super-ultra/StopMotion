//
//  Studio.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 30.10.2024.
//

import SwiftUI

@MainActor
public protocol Studio: AnyObject, Observable {
    /// Top layer always exists
    var currentLayer: Layer { get }
    var layers: [Layer] { get }
    var tool: DrawingTool { get set }
    var toolColor: Color { get set }
    
    var isUndoAvailable: Bool { get }
    var isRedoAvailable: Bool { get }
    
    func drag(_ point: CGPoint)
    func endDragging(_ point: CGPoint)
    func undo()
    func redo()
    
    func makeNewLayer()
    func generateLayers(count: Int)
    func deleteCurrentLayer()
}
