//
//  SmallColorPicker.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 30.10.2024.
//

import SwiftUI

import StopMotionAssets


struct SmallColorPickerModel {
    var selectedColor: Binding<Color>
    var predefinedColors: [Color]
    var onSubmit: (() -> Void)? = nil
}

struct SmallColorPicker: View {

    var model: SmallColorPickerModel
    
    var body: some View {
        HStack(spacing: 16) {
            ColorPicker("", selection: model.selectedColor, supportsOpacity: true)
                .pickerStyle(.palette)
                .labelsHidden()
            
            ForEach(model.predefinedColors, id: \.self) { color in
                ToolViewColorButton(
                    model: ToolViewColorButtonModel(
                        color: color,
                        isSelected: false,
                        action: {
                            model.selectedColor.wrappedValue = color
                            model.onSubmit?()
                        }
                    )
                )
            }
        }
        .overlayControlBackground()
    }
    
    // MARK: - Private
    
    @State
    private var fullPickerSelected: Bool = false
    
}
