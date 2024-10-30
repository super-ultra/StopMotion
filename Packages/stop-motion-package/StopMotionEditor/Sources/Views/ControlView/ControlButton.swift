//
//  ControlButton.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 29.10.2024.
//

import SwiftUI
import StopMotionAssets


struct ControlButtonModel {
    let icon: Image
    let isAvailable: Bool
    let action: () -> Void
}

struct ControlButton: View {
    
    let model: ControlButtonModel
    
    var body: some View {
        Button(
            action: model.action,
            label: {
                model.icon
            }
        )
        .foregroundStyle(
            Color.Assets.tintPrimary
                .opacity(model.isAvailable ? 1.0 : 0.5)
        )
        .disabled(!model.isAvailable)
    }
}
