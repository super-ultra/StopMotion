//
//  ToolViewModel.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import Observation
import SwiftUI

import StopMotionToolbox

enum ToolViewMode: Equatable {
    case tool(DrawingTool)
    case colorPicking
}

@MainActor
protocol ToolViewModel: Observable {
    var color: Color { get }
    var mode: ToolViewMode? { get }
    
    func selectTool(_ tool: DrawingTool)
    func selectColor(_ color: Color)
    func pickColor()
}


struct ToolViewModelMock: ToolViewModel {
    var color: Color
    var mode: ToolViewMode?
    func selectTool(_ tool: DrawingTool) {}
    func selectColor(_ color: Color) {}
    func pickColor() {}
}
