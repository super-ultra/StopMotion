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
                if model.isPlaying {
                    additionalPlaybackControls()
                } else {
                    HStack {
                        actionControls()
                        Spacer()
                    }
                    
                    layerControls()
                }
                
                HStack {
                    Spacer()
                    playbackControls()
                }
            }
            layerInfoView()
        }
        .alert(isPresented: .constant(model.errorState != nil)) {
            Alert(
                title: Text(model.errorState?.message ?? ""),
                dismissButton: .default(Text(Strings.Common.ok)) {
                    model.errorState?.onDismiss()
                }
            )
        }
    }
    
    // MARK: - Private
    
    @State
    private var generateLayersCountText: String = ""
    
    @State
    private var isGenerateLayersCountPresented: Bool = false
        
    @State
    private var isDeleteAllLayersPresented: Bool = false
    
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
    }
    
    @ViewBuilder
    private func layerControls() -> some View {
        HStack(spacing: 8) {
            ControlButton(model: ControlButtonModel(
                icon: .Assets.controlBin,
                isAvailable: model.isDeleteAvailable,
                action: {
                    model.deleteLayer()
                },
                longPressAction: {
                    isDeleteAllLayersPresented = true
                }
            ))
            .confirmationDialog(Strings.DeleteAllLayersAlert.message, isPresented: $isDeleteAllLayersPresented, titleVisibility: .visible) {
                Button(Strings.DeleteAllLayersAlert.deleteAll, role: .destructive) {
                    model.deleteAllLayers()
                }
            }
           
            ControlButton(model: ControlButtonModel(
                icon: .Assets.controlNewLayer,
                action: {
                    model.makeNewLayer()
                }
            ))
            
            ControlButton(model: ControlButtonModel(
                icon: .Assets.controlDuplicate,
                action: {
                    model.duplicateLayer()
                }
            ))
            
            ControlButton(model: ControlButtonModel(
                icon: .Assets.controlGenerateLayers,
                action: {
                    isGenerateLayersCountPresented.toggle()
                }
            ))
            .alert(Strings.ControlView.generateLayersTitle, isPresented: $isGenerateLayersCountPresented) {
                TextField("", text: $generateLayersCountText)
                    .keyboardType(.numberPad)
                
                Button(Strings.Common.ok) {
                    if let count = Int(generateLayersCountText), count > 0 {
                        model.generateLayers(count: count)
                    }
                }
                
                Button(Strings.Common.cancel, role: .cancel) {}
            } message: {
                Text(Strings.ControlView.generateLayersMessage)
            }
            
            ControlButton(model: ControlButtonModel(
                icon: .Assets.controlLayers,
                action: {
                    model.presentAllLayers()
                }
            ))
        }
    }
    
    @ViewBuilder
    private func playbackControls() -> some View {
        HStack(spacing: 8) {
            if model.isPlaying {
                ControlButton(model: ControlButtonModel(
                    icon: .Assets.controlPause,
                    action: {
                        model.pause()
                    }
                ))
            } else {
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
    
    @ViewBuilder
    private func additionalPlaybackControls() -> some View {
        switch model.sharingState {
        case .available:
            ControlButton(model: ControlButtonModel(
                icon: .Assets.systemShare,
                action: {
                    model.share()
                }
            ))
        case .loading:
            ProgressView()
        }
        
    }
    
    @ViewBuilder
    private func layerInfoView() -> some View {
        Text(model.layerCounter)
            .font(.caption2)
            .fontWeight(.medium)
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
