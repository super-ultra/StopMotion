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
    }
    
    // MARK: ToolViewModel
    
    var color: Color {
        studio.toolColor
    }
    
    private(set) var mode: ToolViewMode?
    
    func selectTool(_ tool: DrawingTool) {
        studio.tool = tool
        mode = .tool(tool)
    }
    
    func selectColor(_ color: Color) {
        studio.toolColor = color
        mode = .tool(studio.tool)
    }
    
    func pickColor() {
        mode = .colorPicking
        // TODO: Implement
    }
    
    // MARK: - Private
    
    private let studio: Studio
}
