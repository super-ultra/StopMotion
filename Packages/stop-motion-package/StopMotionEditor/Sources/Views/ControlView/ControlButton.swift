//
//  ControlButton.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 29.10.2024.
//

import SwiftUI
import StopMotionAssets


struct ControlButtonModel {
    var icon: Image
    var isAvailable: Bool
    var action: () -> Void
    var onLongPress: (() -> Void)? = nil
}

struct ControlButton: View {
    
    let model: ControlButtonModel
    
    var body: some View {
        Button(
            action: {},
            label: {
                model.icon
                    .onTapGesture {
                        model.action()
                    }
                    .onLongPressGesture(minimumDuration: 0.1) {
                        model.onLongPress?()
                    }
            }
        )
        .foregroundStyle(
            Color.Assets.tintPrimary
                .opacity(model.isAvailable ? 1.0 : 0.3)
        )
        .disabled(!model.isAvailable)
    }
}
