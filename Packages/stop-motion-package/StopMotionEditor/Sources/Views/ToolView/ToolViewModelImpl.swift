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
        
    init(studio: DrawingStudio, onSelectShape: @escaping (ShapeType) -> Void) {
        self.studio = studio
        self.onSelectShape = onSelectShape
        self.mode = .tool(studio.tool)
        self.tools = DrawingToolType.allCases.reduce(into: [DrawingToolType: DrawingTool]()) { result, type in
            result[type] = DrawingTool.default(type)
        }
    }
    
    // MARK: ToolViewModel
    
    var color: Color {
        Color(studio.toolColor)
    }
    
    private(set) var mode: ToolViewMode?
    
    func selectTool(_ toolType: DrawingToolType) {
        if case .tool(let currentTool) = mode, currentTool.type == toolType {
            let model = SizeSliderViewModel(
                sliderModel: SliderViewModel(
                    value: Binding(
                        get: { [weak self] in
                            self?.studio.tool.size ?? DrawingTool.defaultSizeRange.lowerBound
                        },
                        set: { [weak self] value in
                            self?.selectToolSize(value)
                        }),
                    range: DrawingTool.defaultSizeRange,
                    step: 1
                ),
                color: toolType == .eraser ? .white : color
            )
            
            mode = .sizePicking(currentTool, model)
        } else {
            let tool = tool(toolType)
            studio.tool = tool
            mode = .tool(tool)
            dropToToolModeIfNeeded()
        }
    }
    
    func selectColor(_ color: Color) {
        studio.toolColor = color.resolve(in: EnvironmentValues()).cgColor
        mode = .tool(studio.tool)
    }
    
    func pickColor() {
        switch mode {
        case .colorPicking:
            dropToToolModeIfNeeded()
        default:
            mode = .colorPicking(SmallColorPickerModel(
                selectedColor: Binding<Color>(
                    get: { [studio] in
                        Color(studio.toolColor)
                    },
                    set: { [studio] in
                        studio.toolColor = $0.resolve(in: EnvironmentValues()).cgColor
                    }
                ),
                predefinedColors: Static.defaultColors,
                onSubmit: { [weak self] in
                    self?.dropToToolModeIfNeeded()
                }
            ))
        }
    }
    
    func pickShape() {
        switch mode {
        case .shapePicking:
            dropToToolModeIfNeeded()
        default:
            mode = .shapePicking(
                SmallShapePickerModel(shapes: [.circle, .square, .triangle, .star]) { [weak self] shape in
                    self?.onSelectShape(shape)
                    self?.dropToToolModeIfNeeded()
                }
            )
        }
    }
    
    func dropToToolModeIfNeeded() {
        switch mode {
        case .colorPicking, .sizePicking, .shapePicking:
            mode = .tool(studio.tool)
        case .tool, .none:
            break
        }
    }
    
    // MARK: - Private
    
    
    private enum Static {
        static let defaultColors: [Color] = [.Assets.solidWhite, .Assets.solidRed, .Assets.solidBlack, .Assets.solidBlue]
    }
    
    private let studio: DrawingStudio
    private let onSelectShape: (ShapeType) -> Void
    private var tools: [DrawingToolType: DrawingTool] = [:]
    
    private func tool(_ type: DrawingToolType) -> DrawingTool {
        guard let tool = tools[type] else {
            assertionFailure()
            return .default(type)
        }
        return tool
    }
    
    
    private func selectToolSize(_ size: CGFloat) {
        var tool = studio.tool
        tool.size = size
        studio.tool = tool

        tools[tool.type] = tool
    }
}
