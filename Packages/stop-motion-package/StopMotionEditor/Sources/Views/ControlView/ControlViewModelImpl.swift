//
//  ControlViewModelImpl.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 29.10.2024.
//

import Observation
import SwiftUI
import StopMotionDrawing


@MainActor
@Observable
final class ControlViewModelImpl: ControlViewModel {
    
    init(studio: Studio, router: ControlViewRouter) {
        self.studio = studio
        self.router = router
    }
    
    // MARK: - ControlViewModel
    
    var isUndoAvailable: Bool { studio.isUndoAvailable }
    
    var isRedoAvailable: Bool { studio.isRedoAvailable }
    
    var isDeleteAvailable: Bool { studio.layers.count > 1 || !studio.currentLayer.strokes.isEmpty }
    
    var isPlayAvailable: Bool { studio.layers.count > 1 }
    
    private(set) var isPlaying: Bool = false
    
    var layerCounter: String {
        return "\(studio.currentLayerIndex + 1) / \(studio.layers.count)"
    }
    
    func undo() {
        studio.undo()
    }
    
    func redo() {
        studio.redo()
    }
    
    func deleteLayer() {
        studio.deleteCurrentLayer()
    }
    
    func deleteAllLayers() {
        studio.deleteAllLayers()
    }
    
    func makeNewLayer() {
        studio.makeNewLayer()
    }
    
    func duplicateLayer() {
        studio.duplicateLayer()
    }
    
    func generateLayers(count: Int) {
        studio.generateLayers(count: count)
    }
    
    func presentAllLayers() {
        router.presentAllLayers()
    }
    
    func play() {
        guard isPlayAvailable, !isPlaying else {
            return
        }
        isPlaying = true
    }
    
    func pause() {
        guard isPlaying else {
            return
        }
        isPlaying = false
    }
    
    // MARK: - Private
    
    private let studio: Studio
    private let router: ControlViewRouter
}
