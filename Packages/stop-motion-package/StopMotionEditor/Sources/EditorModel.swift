//
//  EditorModel.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 29.10.2024.
//

@MainActor
protocol EditorModel {
    var controlModel: ControlViewModel { get }
    var canvasModel: CanvasViewModel { get }
    var toolModel: ToolViewModel { get }
}
