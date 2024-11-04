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
    
    var toolScale: CGFloat {
        get {
            studio.toolScale
        }
        set {
            studio.toolScale = newValue
        }
    }
    
    var animationFPS: Int {
        settings.animationFPS
    }
    
    private(set) var placingStroke: Stroke?
    
    func layer(at index: Int) -> Layer {
        studio.layer(at: index)
    }
    
    func updateCanvasSize(_ size: CGSize) {
        studio.canvasSize = size
    }
    
    func drag(_ point: CGPoint) {
        studio.drag(point)
    }
    
    func endDragging(_ point: CGPoint) {
        studio.endDragging(point)
    }

    func tap(_ point: CGPoint) {
        studio.tap(point)
    }
    
    func placeShape(_ shape: ShapeType) {
        let path = makeInitialPath(for: shape)
        placingStroke = Stroke(path: path, color: studio.toolColor, tool: studio.tool)
    }
    
    func submitStrokePlacement(transform: CGAffineTransform) {
        if let placingStroke {
            studio.addStoke(placingStroke.applying(transform))
        }
        placingStroke = nil
    }
    
    // MARK: - Private
    
    private let studio: DrawingStudio
    private let settings: EditorSettings
    
    private func makeInitialPath(for shape: ShapeType) -> Path {
        let size = CGSize(width: 120, height: 120)
        let rect = CGRect(origin: CGPoint(x: 60, y: 60), size: size)
        
        switch shape {
        case .circle:
            return Path(ellipseIn: rect)
        case .square:
            return Path(roundedRect: rect, cornerRadius: 4)
        case .triangle:
            return Path(triangleIn: rect)
        case .star:
            let pointiness: CGFloat = 2.2
            return .star(x: rect.midX, y: rect.midY, radius: size.width / 2 / pointiness, sides: 5, pointiness: pointiness)
        }
    }
}
