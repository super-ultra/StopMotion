//
//  PlaybackSettingsView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 03.11.2024.
//

import SwiftUI

import StopMotionAssets
import StopMotionDrawing


struct PlaybackSettingsView: View {
    
    @State
    var model: PlaybackSettingsViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
                        
            FpsSliderView(model: model.fpsSliderModel)
                .padding(.horizontal, 8)
        }
    }
    
    
}
