//
//  EditorSettingsApp.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 02.11.2024.
//

import SwiftUI

@Observable
final class EditorSettingsApp: EditorSettings {
    
    init() {
        animationFPS = _animationFPSStore.wrappedValue
    }
    
    // MARK: - EditorSettings
    
    var animationFPS: Int {
        didSet {
            animationFPSStore = animationFPS
        }
    }
    
    // MARK: - Impl
    
    @AppStorage("EditorSettings.animationFPS")
    @ObservationIgnored
    private var animationFPSStore: Int = 30
    
}
