//
//  ControlView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import SwiftUI

import StopMotionAssets


struct ControlView: View {
    
    let model: ControlViewModel
    
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                ControlButton(model: ControlButtonModel(
                    icon: .Assets.controlUndo,
                    isAvailable: model.isUndoAvailable,
                    action: {
                        model.undo()
                    }
                ))
                ControlButton(model: ControlButtonModel(
                    icon: .Assets.controlRedo,
                    isAvailable: model.isRedoAvailable,
                    action: {
                        model.redo()
                    }
                ))
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                ControlButton(model: ControlButtonModel(
                    icon: .Assets.controlBin,
                    isAvailable: model.isDeleteAvailable,
                    action: {
                        model.deleteLayer()
                    }
                ))
                ControlButton(model: ControlButtonModel(
                    icon: .Assets.controlNewLayer,
                    isAvailable: true,
                    action: {
                        model.makeNewLayer()
                    }
                ))
                ControlButton(model: ControlButtonModel(
                    icon: .Assets.controlLayers,
                    isAvailable: true,
                    action: {
                        model.showAllLayers()
                    }
                ))
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                ControlButton(model: ControlButtonModel(
                    icon: .Assets.controlPause,
                    isAvailable: model.isPauseAvailable,
                    action: {
                        model.pause()
                    }
                ))
                ControlButton(model: ControlButtonModel(
                    icon: .Assets.controlPlay,
                    isAvailable: model.isPlayAvailable,
                    action: {
                        model.play()
                    }
                ))
            }
        }
    }
    
}


#Preview(traits: .sizeThatFitsLayout) {
    VStack(spacing: 16) {
        ControlView(model: ControlViewModelMock(
            isUndoAvailable: true,
            isRedoAvailable: false,
            isDeleteAvailable: true,
            isPlayAvailable: true,
            isPauseAvailable: true
        ))
        
        ControlView(model: ControlViewModelMock(
            isUndoAvailable: false,
            isRedoAvailable: false,
            isDeleteAvailable: false,
            isPlayAvailable: false,
            isPauseAvailable: false
        ))
    }
    .frame(width: 350)
    .padding(16)
}
