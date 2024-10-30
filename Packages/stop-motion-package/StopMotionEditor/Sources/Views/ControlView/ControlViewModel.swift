//
//  ControlViewModel.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 29.10.2024.
//

import Foundation
import Observation


@MainActor
protocol ControlViewModel: Observable {
    var isUndoAvailable: Bool { get }
    var isRedoAvailable: Bool { get }
    var isDeleteAvailable: Bool { get }
    var isPlayAvailable: Bool { get }
    var isPauseAvailable: Bool { get }
    
    func undo()
    func redo()
    func deleteLayer()
    func makeNewLayer()
    func showAllLayers()
    func play()
    func pause()
}


struct ControlViewModelMock: ControlViewModel {
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
