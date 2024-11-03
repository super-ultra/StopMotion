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
    
    init(studio: DrawingStudio, settings: EditorSettings) {
        self.studio = studio
        self.settings = settings
    }
    
    // MARK: - CanvasViewModel
    
    var currentLayer: Layer {
        studio.currentLayer
    }
    
    var previousLayer: Layer? {
        if studio.currentLayerIndex > 0 {
            return studio.layer(at: studio.currentLayerIndex - 1)
        } else {
            return nil
        }
    }
    
    var layersCount: Int {
        studio.layersCount
    }
    
    var tool: DrawingTool {
        studio.tool
    }
    
    var toolColor: Color {
        Color(studio.toolColor)
    }
    
    var animationFPS: Int {
        settings.animationFPS
    }
    
    func layer(at index: Int) -> Layer {
        studio.layer(at: index)
    }
    
    func drag(_ point: CGPoint) {
        studio.drag(point)
    }
    
    func endDragging(_ point: CGPoint) {
        studio.endDragging(point)
    }
    
    // MARK: - Private
    
    private let studio: DrawingStudio
    private let settings: EditorSettings
    
}
