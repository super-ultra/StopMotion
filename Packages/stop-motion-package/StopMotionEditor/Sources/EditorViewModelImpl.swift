//
//  EditorModelImpl.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 29.10.2024.
//

import StopMotionDrawing
import StopMotionAssets

import SwiftUI
import Observation


@MainActor
final class EditorViewModelImpl: EditorViewModel {
    
    init() {
        router = EditorViewRouterImpl(studio: studio)
        controlModel = ControlViewModelImpl(studio: studio, settings: settings, router: router)
        canvasModel = CanvasViewModelImpl(studio: studio, settings: settings)
        toolModel = ToolViewModelImpl(studio: studio)
    }
    
    // MARK: - EditorModel
    
    var router: EditorViewRouter
    
    let controlModel: ControlViewModel
    
    let canvasModel: CanvasViewModel
    
    let toolModel: ToolViewModel
    
    // MARK: - Private
    
    private enum Static {
        static let initialTool: DrawingTool = .default(.pencil)
        static let initialColor: Color = .Assets.solidBlue
    }
    
    private let studio: Studio = StudioImpl(tool: Static.initialTool, color: Static.initialColor)
    private let settings: EditorSettings = EditorSettingsApp()
}
