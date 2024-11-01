//
//  ToolViewModel.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import Observation
import SwiftUI

import StopMotionDrawing

enum ToolViewMode: Equatable {
    case tool(DrawingTool)
    case colorPicking
    case sizePicking(DrawingTool)
}

@MainActor
protocol ToolViewModel: Observable {
    var color: Color { get }
    var mode: ToolViewMode? { get }
    
    func selectTool(_ toolType: DrawingToolType)
    func selectColor(_ color: Color)
    func pickColor()
    func dropToToolModeIfNeeded()
}


struct ToolViewModelMock: ToolViewModel {
    var color: Color
    var mode: ToolViewMode?
    func selectTool(_ toolType: DrawingToolType) {}
    func selectColor(_ color: Color) {}
    func pickColor() {}
    func dropToToolModeIfNeeded() {}
}


extension ToolViewMode {
    func isTool(_ toolType: DrawingToolType) -> Bool {
        switch self {
        case .colorPicking:
            return false
        case .sizePicking(let tool), .tool(let tool):
            return tool.type == toolType
        }
    }
}

extension ToolViewModel {
    func isToolSelected(_ toolType: DrawingToolType) -> Bool {
        mode?.isTool(toolType) ?? false
    }
}
