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
    var isAvailable: Bool = true
    var action: () -> Void
    var longPressAction: (() -> Void)? = nil
}

struct ControlButton: View {
    
    let model: ControlButtonModel
    
    var body: some View {
        Button(
            action: {
            },
            label: {
                model.icon
            }
        )
        .simultaneousGesture(
            LongPressGesture().onEnded { _ in
                model.longPressAction?()
            }
        )
        .simultaneousGesture(
            TapGesture().onEnded {
                model.action()
            }
        )
        .buttonStyle(.scale)
        .font(.system(size: 24))
        .frame(width: 32, height: 32)
        .foregroundStyle(
            Color.Assets.tintPrimary
                .opacity(model.isAvailable ? 1.0 : 0.3)
        )
        .disabled(!model.isAvailable)
    }
}
