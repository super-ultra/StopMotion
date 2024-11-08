//
//  ShapePicker.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 03.11.2024.
//

import SwiftUI

import StopMotionAssets
import StopMotionDrawing


struct SmallShapePickerModel {
    var shapes: [ShapeType]
    var onSelect: (ShapeType) -> Void
}

struct SmallShapePicker: View {

    var model: SmallShapePickerModel
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(model.shapes, id: \.self) { shape in
                ControlButton(model: ControlButtonModel(
                    icon: image(for: shape),
                    action: {
                        model.onSelect(shape)
                    }
                ))
            }
        }
        .overlayControlBackground()
    }
    
    // MARK: - Private
    
    @State
    private var fullPickerSelected: Bool = false

    private func image(for shape: ShapeType) -> Image {
        return switch shape {
        case .circle: .Assets.systemShapeCircle
        case .square: .Assets.systemShapeSquare
        case .triangle: .Assets.systemShapeTriangle
        case .star: .Assets.systemShapeStar
        }
    }
    
}

