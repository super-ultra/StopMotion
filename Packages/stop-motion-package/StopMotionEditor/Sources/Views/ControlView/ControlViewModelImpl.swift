//
//  ControlViewModelImpl.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 29.10.2024.
//

import Observation

@MainActor
@Observable
final class ControlViewModelImpl: ControlViewModel {
    
    init() {
        isUndoAvailable = true
        isRedoAvailable = true
        isDeleteAvailable = true
        isPlayAvailable = true
        isPauseAvailable = true
    }
    
    // MARK: - ControlViewModel
    
    var isUndoAvailable: Bool
    var isRedoAvailable: Bool
    var isDeleteAvailable: Bool
    var isPlayAvailable: Bool
    var isPauseAvailable: Bool
    
    func undo() {}
    func redo() {}
    func deleteLayer() {}
    func makeNewLayer() {}
    func showAllLayers() {}
    func play() {}
    func pause() {}
}
