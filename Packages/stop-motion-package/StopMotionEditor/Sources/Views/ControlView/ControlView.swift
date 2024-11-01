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
        VStack(spacing: 4) {
            HStack {
                actionControls()
                
                Spacer()
                
                layerControls()
                
                Spacer()
                
                playbackControls()
            }
            layerInfoView()
        }
    }
    
    // MARK: - Private
    
    @State
    private var generateLayersCountText: String = ""
    
    @State
    private var isGenerateLayersCountPresented: Bool = false
    
    @State
    private var isAllLayersPresented: Bool = false
    
    @ViewBuilder
    private func actionControls() -> some View {
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
    }
    
    @ViewBuilder
    private func layerControls() -> some View {
        HStack(spacing: 8) {
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
                icon: .Assets.controlDuplicate,
                isAvailable: true,
                action: {
                    model.duplicateLayer()
                }
            ))
            
            ControlButton(model: ControlButtonModel(
                icon: .Assets.controlGenerateLayers,
                isAvailable: true,
                action: {
                    isGenerateLayersCountPresented.toggle()
                }
            ))
            .alert("New layers", isPresented: $isGenerateLayersCountPresented) {
                TextField("", text: $generateLayersCountText)
                    .keyboardType(.numberPad)
                
                Button("Ok") {
                    if let count = Int(generateLayersCountText), count > 0 {
                        model.generateLayers(count: count)
                    }
                }
                
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Enter the number of layers to generate.")
            }
            
            ControlButton(model: ControlButtonModel(
                icon: .Assets.controlLayers,
                isAvailable: true,
                action: {
                    model.presentAllLayers()
                }
            ))
        }
        .opacity(model.isPlaying ? 0.0 : 1.0)
    }
    
    @ViewBuilder
    private func playbackControls() -> some View {
        HStack(spacing: 8) {
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
    
    @ViewBuilder
    private func layerInfoView() -> some View {
        Text(model.layerCounter)
            .font(.caption2)
            .foregroundStyle(.secondary)
            .opacity(model.isPlaying ? 0.0 : 1.0)
    }
    
}


#Preview(traits: .sizeThatFitsLayout) {
    VStack(spacing: 16) {
        ControlView(model: ControlViewModelMock(
            isUndoAvailable: true,
            isRedoAvailable: false,
            isDeleteAvailable: true,
            isPlayAvailable: true,
            isPlaying: false,
            layerCounter: "1 / 10"
        ))
        
        ControlView(model: ControlViewModelMock(
            isUndoAvailable: false,
            isRedoAvailable: false,
            isDeleteAvailable: false,
            isPlayAvailable: false,
            isPlaying: false,
            layerCounter: "1 / 10"
        ))
        
        ControlView(model: ControlViewModelMock(
            isUndoAvailable: false,
            isRedoAvailable: false,
            isDeleteAvailable: false,
            isPlayAvailable: true,
            isPlaying: true,
            layerCounter: "1 / 10"
        ))
    }
    .frame(width: 350)
    .padding(16)
}
