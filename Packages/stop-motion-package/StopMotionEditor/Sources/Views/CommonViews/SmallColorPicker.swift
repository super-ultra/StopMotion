//
//  SmallColorPicker.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 30.10.2024.
//

import SwiftUI

import StopMotionAssets

struct SmallColorPicker: View {
    
    var colors: [Color] = Static.defaultColors
    
    var onSelect: (Color) -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(colors, id: \.self) { color in
                ToolViewColorButton(
                    model: ToolViewColorButtonModel(
                        color: color,
                        isSelected: false,
                        action: {
                            onSelect(color)
                        }))
            }
        }
        .padding(16)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 16, style: .continuous)
        )
    }
    
    // MARK: - Private
    
    private enum Static {
        static let defaultColors: [Color] = [.Assets.solidWhite, .Assets.solidRed, .Assets.solidBlack, .Assets.solidBlue]
    }
    
}
