//
//  SizeSlider.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 02.11.2024.
//

import SwiftUI

import StopMotionAssets


struct SizeSliderView: View {
    
    var model: SliderViewModel
    
    init(model: SliderViewModel) {
        self.model = model
        _value = model.value
    }
    
    var body: some View {
        HStack(spacing: 8) {
            SliderView(model: model)
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
    SizeSliderView(model: SliderViewModel(value: .constant(5), range: 0.0...10.0, step: 1.0))
}
