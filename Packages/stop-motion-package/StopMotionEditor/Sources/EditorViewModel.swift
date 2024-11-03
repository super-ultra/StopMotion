//
//  EditorModel.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 29.10.2024.
//

@MainActor
protocol EditorViewModel: AnyObject {
    var router: EditorViewRouter { get }
    
    var controlModel: ControlViewModel { get }
    var toolModel: ToolViewModel { get }
    var canvasModel: CanvasViewModel { get }
    var playbackSettingsModel: PlaybackSettingsViewModel { get }
}
