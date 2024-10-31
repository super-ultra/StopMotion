//
//  ControlViewModelImpl.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 29.10.2024.
//

import Observation
import StopMotionDrawing

@MainActor
@Observable
final class ControlViewModelImpl: ControlViewModel {
    
    init(studio: Studio) {
        self.studio = studio
        isDeleteAvailable = true
        isPlaying = false
    }
    
    // MARK: - ControlViewModel
    
    var isUndoAvailable: Bool { studio.isUndoAvailable }
    
    var isRedoAvailable: Bool { studio.isRedoAvailable }
    
    var isDeleteAvailable: Bool
    
    var isPlayAvailable: Bool { studio.layers.count > 1 }
    
    var isPlaying: Bool
    
    func undo() {
        studio.undo()
    }
    
    func redo() {
        studio.redo()
    }
    
    func deleteLayer() {
        studio.deleteCurrentLayer()
    }
    
    func makeNewLayer() {
        studio.makeNewLayer()
    }
    
    func showAllLayers() {}
    
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
}
