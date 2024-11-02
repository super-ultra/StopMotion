//
//  SizeSlider.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 02.11.2024.
//

import SwiftUI

import StopMotionAssets


struct SizeSliderModel {
    let value: Binding<CGFloat>
    let range: ClosedRange<CGFloat>
    let step: CGFloat
}

struct SizeSlider: View {
    
    var model: SizeSliderModel
    
    init(model: SizeSliderModel) {
        self.model = model
        _value = model.value
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Slider(value: $value, in: model.range, step: model.step)
            Group {
                Circle()
                    .frame(width: value)
            }
            .frame(width: model.range.upperBound, height: model.range.upperBound)
            .padding([.leading, .trailing], 8)
        }
        .padding(16)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 16, style: .continuous)
        )
    }
    
    // MARK: - Private
    
    @Binding
    private var value: CGFloat
    
}


#Preview(traits: .sizeThatFitsLayout) {
    SizeSlider(model: SizeSliderModel(value: .constant(5), range: 0.0...10.0, step: 1.0))
}
