//
//  CanvasViewModelImpl.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 30.10.2024.
//

import CoreGraphics
import Observation

import StopMotionDrawing

@MainActor
@Observable
final class CanvasViewModelImpl: CanvasViewModel {
    
    init(studio: Studio) {
        self.studio = studio
    }
    
    // MARK: - CanvasViewModel
    
    var layer: Layer {
        studio.layer
    }
    
    func drag(_ point: CGPoint) {
        studio.drag(point)
    }
    
    func endDragging(_ point: CGPoint) {
        studio.endDragging(point)
    }
    
    // MARK: - Private
    
    private let studio: Studio
    
}
