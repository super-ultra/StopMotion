//
//  ControlViewModel.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 29.10.2024.
//

import Foundation
import Observation


enum ControlButtonState {
    case available
    case loading
}


struct ControlViewErrorState {
    var message: String
    var onDismiss: () -> Void
}

@MainActor
protocol ControlViewModel: Observable {
    var isUndoAvailable: Bool { get }
    var isRedoAvailable: Bool { get }
    var isDeleteAvailable: Bool { get }
    var isPlayAvailable: Bool { get }
    var isPlaying: Bool { get }
    var layerCounter: String { get }
    var sharingState: ControlButtonState { get }
    var generateState: ControlButtonState { get }
    var errorState: ControlViewErrorState? { get }
    
    func undo()
    func redo()
    func deleteLayer()
    func deleteAllLayers()
    func makeNewLayer()
    func duplicateLayer()
    func generateLayers(count: Int)
    func presentAllLayers()
    func play()
    func pause()
    func share()
}


struct ControlViewModelMock: ControlViewModel {
    var isUndoAvailable: Bool
    var isRedoAvailable: Bool
    var isDeleteAvailable: Bool
    var isPlayAvailable: Bool
    var isPlaying: Bool
    var layerCounter: String
    var sharingState: ControlButtonState = .available
    var generateState: ControlButtonState = .available
    var errorState: ControlViewErrorState? = nil
    
    func undo() {}
    func redo() {}
    func deleteLayer() {}
    func deleteAllLayers() {}
    func makeNewLayer() {}
    func duplicateLayer() {}
    func generateLayers(count: Int) {}
    func presentAllLayers() {}
    func play() {}
    func pause() {}
    func share() {}
}
