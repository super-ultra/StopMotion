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
final class EditorModelImpl: EditorModel {
    
    init() {
        controlModel = ControlViewModelImpl(studio: studio)
        canvasModel = CanvasViewModelImpl(studio: studio)
        toolModel = ToolViewModelImpl(studio: studio)
    }
    
    // MARK: - EditorModel
    
    let controlModel: ControlViewModel
    
    let canvasModel: CanvasViewModel
    
    let toolModel: ToolViewModel
    
    // MARK: - Private
    
    private enum Static {
        static let initialTool: DrawingTool = .pencil
        static let initialColor: Color = .Assets.solidBlue
    }
    
    private let studio: Studio = StudioImpl(tool: Static.initialTool, color: Static.initialColor)
    
}


// MARK: - Private Utils

extension ToolViewMode {
    fileprivate var currentTool: DrawingTool? {
        switch self {
        case .tool(let tool): return tool
        case .colorPicking: return nil
        }
    }
}
