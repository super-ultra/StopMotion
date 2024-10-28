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
        HStack(spacing: 16) {
            ToolViewButton(model: ToolViewButtonModel(
                icon: .Assets.toolPencil,
                isSelected: model.mode == .tool(.pencil),
                action: { model.selectTool(.pencil) }
            ))
            
            ToolViewButton(model: ToolViewButtonModel(
                icon: .Assets.toolErase,
                isSelected: model.mode == .tool(.eraser),
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


#Preview(traits: .sizeThatFitsLayout) {
    VStack(spacing: 16) {
        ToolView(model: ToolViewModelMock(
            color: .Assets.solidBlue,
            mode: .tool(.eraser)
        ))
        
        ToolView(model: ToolViewModelMock(
            color: .Assets.solidBlue,
            mode: .colorPicking
        ))
        
        ToolView(model: ToolViewModelMock(
            color: .Assets.solidBlue,
            mode: nil
        ))
    }.padding(16)
}
