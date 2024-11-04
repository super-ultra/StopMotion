//
//  ControlView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import SwiftUI

import StopMotionAssets
import StopMotionDrawing


struct ToolView: View {
    
    @State
    var model: ToolViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            pickerViews()
            
            HStack(spacing: 16) {
                ControlButton(model: ControlButtonModel(
                    icon: .Assets.toolPencil,
                    isSelected: model.isToolSelected(.pencil),
                    action: { model.selectTool(.pencil) }
                ))
                
                ControlButton(model: ControlButtonModel(
                    icon: .Assets.toolBrush,
                    isSelected: model.isToolSelected(.brush),
                    action: { model.selectTool(.brush) }
                ))
                
                ControlButton(model: ControlButtonModel(
                    icon: .Assets.toolErase,
                    isSelected: model.isToolSelected(.eraser),
                    action: { model.selectTool(.eraser) }
                ))
                
                ControlButton(model: ControlButtonModel(
                    icon: .Assets.systemShapeStar,
                    isSelected: model.isShapePicking,
                    action: { model.pickShape() }
                ))
                
                ToolViewColorButton(model: ToolViewColorButtonModel(
                    color: model.color,
                    isSelected: model.isColorPicking,
                    action: { model.pickColor() }
                ))
            }
        }
    }
    
    // MARK: - Private
    
    @ViewBuilder
    private func pickerViews() -> some View {
        switch model.mode {
        case .colorPicking(let colorModel):
            SmallColorPicker(model: colorModel)
            .padding(.horizontal, 24)
        case .sizePicking(_, let sliderModel):
            SizeSliderView(model: sliderModel)
                .padding(.horizontal, 24)
        case .shapePicking(let model):
            SmallShapePicker(model: model)
        case .tool, .none:
            EmptyView()
        }
    }

}


#Preview(traits: .sizeThatFitsLayout) {
    VStack(spacing: 16) {
        ToolView(model: ToolViewModelMock(
            color: .Assets.solidBlue,
            mode: .tool(.default(.eraser))
        ))
        .frame(height: 60)
        
        ToolView(model: ToolViewModelMock(
            color: .Assets.solidBlue,
            mode: .colorPicking(SmallColorPickerModel(
                selectedColor: .constant(.red),
                predefinedColors: [.red, .green, .blue])
            )
        ))
        .frame(height: 60)
        
        ToolView(model: ToolViewModelMock(
            color: .Assets.solidBlue,
            mode: nil
        ))
        .frame(height: 60)
    }.padding(16)
}
