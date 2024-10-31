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
            .opacity(model.isPlaying ? 0.0 : 1.0)
            
            Spacer()
            
            HStack(spacing: 12) {
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
                    icon: .Assets.controlGenerateLayers,
                    isAvailable: true,
                    action: {
                        model.generateLayers()
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
            .opacity(model.isPlaying ? 0.0 : 1.0)
            
            Spacer()
            
            HStack(spacing: 16) {
                ControlButton(model: ControlButtonModel(
                    icon: .Assets.controlPause,
                    isAvailable: model.isPlaying,
                    action: {
                        model.pause()
                    }
                ))
                ControlButton(model: ControlButtonModel(
                    icon: .Assets.controlPlay,
                    isAvailable: model.isPlayAvailable && !model.isPlaying,
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
            isPlaying: false
        ))
        
        ControlView(model: ControlViewModelMock(
            isUndoAvailable: false,
            isRedoAvailable: false,
            isDeleteAvailable: false,
            isPlayAvailable: false,
            isPlaying: false
        ))
        
        ControlView(model: ControlViewModelMock(
            isUndoAvailable: false,
            isRedoAvailable: false,
            isDeleteAvailable: false,
            isPlayAvailable: true,
            isPlaying: true
        ))
    }
    .frame(width: 350)
    .padding(16)
}
