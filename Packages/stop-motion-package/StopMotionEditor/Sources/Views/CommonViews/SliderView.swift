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
    }
     
    var body: some View {
        HStack {
            Slider(
                value: model.value,
                in: model.range,
                step: model.step
            )
            .accentColor(.Assets.tintAccent)
        }
    }
}
