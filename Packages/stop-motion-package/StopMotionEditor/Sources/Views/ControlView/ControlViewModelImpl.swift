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
        isPlayAvailable = true
        isPauseAvailable = true
    }
    
    // MARK: - ControlViewModel
    
    var isUndoAvailable: Bool { studio.isUndoAvailable }
    var isRedoAvailable: Bool { studio.isRedoAvailable }
    var isDeleteAvailable: Bool
    var isPlayAvailable: Bool
    var isPauseAvailable: Bool
    
    func undo() {
        studio.undo()
    }
    
    func redo() {
        studio.redo()
    }
    
    func deleteLayer() {}
    
    func makeNewLayer() {}
    
    func showAllLayers() {}
    
    func play() {}
    
    func pause() {}
    
    // MARK: - Private
    
    private let studio: Studio
}
