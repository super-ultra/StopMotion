//
//  SizeSlider.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 02.11.2024.
//

import SwiftUI

import StopMotionAssets

struct SizeSliderViewModel {
    var sliderModel: SliderViewModel
    var color: Color
}


struct SizeSliderView: View {
    
    var model: SizeSliderViewModel
    
    init(model: SizeSliderViewModel) {
        self.model = model
        _value = model.sliderModel.value
    }
    
    var body: some View {
        HStack(spacing: 8) {
            SliderView(model: model.sliderModel)
            Group {
                Circle()
                    .frame(width: value)
                    .foregroundStyle(model.color)
            }
            .frame(width: model.sliderModel.range.upperBound, height: model.sliderModel.range.upperBound)
            .padding(.horizontal, 8)
        }
        .overlayControlBackground()
    }
    
    // MARK: - Private
    
    @Binding
    private var value: CGFloat
}


#Preview(traits: .sizeThatFitsLayout) {
    SizeSliderView(model: SizeSliderViewModel(
        sliderModel: SliderViewModel(value: .constant(5), range: 0.0...10.0, step: 1.0),
        color: .red
    ))
}
