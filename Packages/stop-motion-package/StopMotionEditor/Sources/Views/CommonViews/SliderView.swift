//
//  SliderView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 02.11.2024.
//

import SwiftUI

import StopMotionAssets


struct SliderViewModel {
    let value: Binding<CGFloat>
    let range: ClosedRange<CGFloat>
    let step: CGFloat
}

struct SliderView: View {
    
    @State
    var model: SliderViewModel
    
    init(model: SliderViewModel) {
        self.model = model
        _value = model.value
    }
     
    var body: some View {
        HStack {
            Slider(
                value: $value,
                in: model.range,
                step: model.step
            )
            .accentColor(.Assets.tintAccent)
            
            Text("\(Int(value))")
                .font(.caption)
                .bold()
                .frame(width: 20)
        }
    }
    
    // MARK: - Private
    
    @Binding
    private var value: CGFloat
}
