//
//  ToolViewModel.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import Observation
import SwiftUI

import StopMotionDrawing

enum ToolViewMode {
    case tool(DrawingTool)
    case colorPicking(SmallColorPickerModel)
    case sizePicking(DrawingTool, SizeSliderViewModel)
    case shapePicking(SmallShapePickerModel)
}

@MainActor
protocol ToolViewModel: Observable {
    var color: Color { get }
    var mode: ToolViewMode? { get }
    
    func selectTool(_ toolType: DrawingToolType)
    func selectColor(_ color: Color)
    func pickColor()
    func pickShape()
    func dropToToolModeIfNeeded()
}


struct ToolViewModelMock: ToolViewModel {
    var color: Color
    var mode: ToolViewMode?
    func selectTool(_ toolType: DrawingToolType) {}
    func selectColor(_ color: Color) {}
    func pickColor() {}
    func pickShape() {}
    func dropToToolModeIfNeeded() {}
}


extension ToolViewMode {
    func isTool(_ toolType: DrawingToolType) -> Bool {
        switch self {
        case .colorPicking, .shapePicking:
            return false
        case .sizePicking(let tool, _), .tool(let tool):
            return tool.type == toolType
        }
    }
    
    var isColorPicking: Bool {
        switch self {
        case .colorPicking:
            return true
        case .sizePicking, .tool, .shapePicking:
            return false
        }
    }
    
    var isShapePicking: Bool {
        switch self {
        case .shapePicking:
            return true
        case .colorPicking, .tool, .sizePicking:
            return false
        }
    }
}

extension ToolViewModel {
    func isToolSelected(_ toolType: DrawingToolType) -> Bool {
        mode?.isTool(toolType) ?? false
    }
    
    var isColorPicking: Bool {
        mode?.isColorPicking ?? false
    }
    
    var isShapePicking: Bool {
        mode?.isShapePicking ?? false
    }
}
