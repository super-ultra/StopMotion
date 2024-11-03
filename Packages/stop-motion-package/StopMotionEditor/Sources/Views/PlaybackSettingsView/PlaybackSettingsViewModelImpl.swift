//
//  PlaybackSettingsViewModelImpl.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 03.11.2024.
//

import Foundation
import SwiftUI

@MainActor
final class PlaybackSettingsViewModelImpl: PlaybackSettingsViewModel {
    
    init(settings: EditorSettings) {
        self.settings = settings
        
        self.fpsSliderModel = SliderViewModel(
            value: Binding(get: { CGFloat(settings.animationFPS) }, set: { settings.animationFPS = Int($0) }),
            range: 1...60,
            step: 1
        )
    }
    
    // MARK: - ControlViewModel
    
    let fpsSliderModel: SliderViewModel
    
    // MARK: - Private
    
    private let settings: EditorSettings
}
