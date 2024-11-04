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
    var isSelected: Bool = false
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
        .frame(width: ControlViewGuides.buttonSize.width, height: ControlViewGuides.buttonSize.height)
        .foregroundStyle(
            foregroundColor()
        )
        .disabled(!model.isAvailable)
    }
    
    // MARK: - Private
    
    private func foregroundColor() -> Color {
        if model.isAvailable {
            return model.isSelected ? .Assets.tintAccent : .Assets.tintPrimary
        } else {
            return .Assets.tintPrimary.opacity(0.3)
        }
    }
}
