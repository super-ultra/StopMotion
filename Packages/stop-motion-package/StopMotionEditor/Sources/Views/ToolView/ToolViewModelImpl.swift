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
        studio.color
    }
    
    private(set) var mode: ToolViewMode?
    
    func selectTool(_ tool: DrawingTool) {
        studio.tool = tool
        mode = .tool(tool)
    }
    
    func selectColor(_ color: Color) {
        studio.color = color
    }
    
    func pickColor() {
        mode = .colorPicking
        // TODO: Implement
    }
    
    // MARK: - Private
    
    private let studio: Studio
}
