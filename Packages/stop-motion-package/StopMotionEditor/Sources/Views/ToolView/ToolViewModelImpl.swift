//
//  ToolViewModelImpl.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 29.10.2024.
//

import Observation
import SwiftUI

import StopMotionAssets
import StopMotionDrawing


@MainActor
@Observable
final class ToolViewModelImpl: ToolViewModel {
    
    init(studio: Studio) {
        self.studio = studio
        self.mode = .tool(studio.tool)
        self.tools = [
            .pencil: .default(.pencil),
            .eraser: .default(.eraser),
        ]
    }
    
    // MARK: ToolViewModel
    
    var color: Color {
        studio.toolColor
    }
    
    private(set) var mode: ToolViewMode?
    
    func selectTool(_ toolType: DrawingToolType) {
        if case .tool(let currentTool) = mode, currentTool.type == toolType {
            mode = .sizePicking(currentTool)
        } else {
            let tool = tool(toolType)
            studio.tool = tool
            mode = .tool(tool)
        }
    }
    
    func selectColor(_ color: Color) {
        studio.toolColor = color
        mode = .tool(studio.tool)
    }
    
    func pickColor() {
        if mode == .colorPicking {
            dropToToolModeIfNeeded()
        } else {
            mode = .colorPicking
        }
    }
    
    func dropToToolModeIfNeeded() {
        switch mode {
        case .colorPicking, .sizePicking:
            mode = .tool(studio.tool)
        case .tool, .none:
            break
        }
    }
    
    // MARK: - Private
    
    private let studio: Studio
    private var tools: [DrawingToolType: DrawingTool] = [:]
    
    private func tool(_ type: DrawingToolType) -> DrawingTool {
        guard let tool = tools[type] else {
            assertionFailure()
            return .default(type)
        }
        return tool
    }
}
