//
//  FPSSliderView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 03.11.2024.
//


import SwiftUI

import StopMotionAssets


struct FpsSliderView: View {
    
    var model: SliderViewModel
    
    init(model: SliderViewModel) {
        self.model = model
        _value = model.value
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Text(Strings.FpsSliderView.fps(Int(value)))
                .font(.body)
                .fontWeight(.medium)
                .frame(width: 64, alignment: .leading)
            SliderView(model: model)
        }
        .padding(.trailing, 16)
    }
    
    // MARK: - Private
    
    @Binding
    private var value: CGFloat
    
}
