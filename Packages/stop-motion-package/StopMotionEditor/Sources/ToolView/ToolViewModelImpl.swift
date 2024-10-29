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
    
    init() {
        color = .Assets.solidBlue
    }
    
    // MARK: ToolViewModel
    
    private(set) var color: Color
    
    private(set) var mode: ToolViewMode?
    
    func selectTool(_ tool: DrawingTool) {
        mode = .tool(tool)
    }
    
    func selectColor(_ color: Color) {
        self.color = color
    }
    
    func pickColor() {
        mode = .colorPicking
        // TODO: Implement
    }
    
}
