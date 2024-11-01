//
//  ControlView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import SwiftUI

import StopMotionAssets


struct ToolView: View {
    
    let model: ToolViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            pickerViews()
            
            HStack(spacing: 16) {
                ToolViewButton(model: ToolViewButtonModel(
                    icon: .Assets.toolPencil,
                    isSelected: model.isToolSelected(.pencil),
                    action: { model.selectTool(.pencil) }
                ))
                
                ToolViewButton(model: ToolViewButtonModel(
                    icon: .Assets.toolErase,
                    isSelected: model.isToolSelected(.eraser),
                    action: { model.selectTool(.eraser) }
                ))
                
                ToolViewColorButton(model: ToolViewColorButtonModel(
                    color: model.color,
                    isSelected: model.mode == .colorPicking,
                    action: { model.pickColor() }
                ))
            }
        }
    }
    
    // MARK: - Private
    
    @ViewBuilder
    private func pickerViews() -> some View {
        switch model.mode {
        case .colorPicking:
            SmallColorPicker { color in
                model.selectColor(color)
            }
        case .sizePicking(let tool):
            EmptyView()
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
        .background(.gray)
        
        ToolView(model: ToolViewModelMock(
            color: .Assets.solidBlue,
            mode: .colorPicking
        ))
        .background(.gray)
        
        ToolView(model: ToolViewModelMock(
            color: .Assets.solidBlue,
            mode: nil
        ))
        .background(.gray)
    }.padding(16)
}
