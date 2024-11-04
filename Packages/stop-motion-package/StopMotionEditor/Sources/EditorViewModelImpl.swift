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
        
        controlModel = ControlViewModelImpl(
            studio: studio,
            settings: settings,
            router: router
        )
        
        canvasModel = CanvasViewModelImpl(studio: studio, settings: settings)
        
        toolModel = ToolViewModelImpl(studio: studio, onSelectShape: { [canvasModel] shape in
            canvasModel.placeShape(shape)
        })
        
        playbackSettingsModel = PlaybackSettingsViewModelImpl(settings: settings)
    }
    
    // MARK: - EditorModel
    
    var router: EditorViewRouter
    
    var isLoading: Bool {
        studio.isLayersGenerating
    }
    
    let controlModel: ControlViewModel
    
    let canvasModel: CanvasViewModel
    
    let toolModel: ToolViewModel
    
    let playbackSettingsModel: PlaybackSettingsViewModel
    
    // MARK: - Private
    
    private enum Static {
        static let initialTool: DrawingTool = .default(.brush)
        static let initialColor: CGColor = UIColor.Assets.solidRed.cgColor
    }
    
    private let studio: DrawingStudio = DrawingStudioImpl(tool: Static.initialTool, color: Static.initialColor)
    private let settings: EditorSettings = EditorSettingsApp()
}
