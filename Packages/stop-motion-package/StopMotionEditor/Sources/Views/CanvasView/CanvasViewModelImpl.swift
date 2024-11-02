//
//  CanvasViewModelImpl.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 30.10.2024.
//

import CoreGraphics
import Observation
import SwiftUI

import StopMotionDrawing

@MainActor
@Observable
final class CanvasViewModelImpl: CanvasViewModel {
    
    init(studio: Studio, settings: EditorSettings) {
        self.studio = studio
        self.settings = settings
    }
    
    // MARK: - CanvasViewModel
    
    var currentLayer: Layer {
        studio.currentLayer
    }
    
    var previousLayer: Layer? {
        if studio.currentLayerIndex > 0 {
            return studio.layers[studio.currentLayerIndex - 1]
        } else {
            return nil
        }
    }
    
    var layers: [Layer] {
        studio.layers
    }
    
    var tool: DrawingTool {
        studio.tool
    }
    
    var toolColor: Color {
        studio.toolColor
    }
    
    var animationFPS: Int {
        settings.animationFPS
    }
    
    func drag(_ point: CGPoint) {
        studio.drag(point)
    }
    
    func endDragging(_ point: CGPoint) {
        studio.endDragging(point)
    }
    
    // MARK: - Private
    
    private let studio: Studio
    private let settings: EditorSettings
    
}
