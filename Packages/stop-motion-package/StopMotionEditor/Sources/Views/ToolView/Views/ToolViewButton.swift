//
//  ToolViewButton.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import SwiftUI
import StopMotionAssets


struct ToolViewButtonModel {
    var icon: Image
    var isSelected: Bool = false
    var action: () -> Void
}


struct ToolViewButton: View {
    
    let model: ToolViewButtonModel
    
    var body: some View {
        Button(
            action: model.action,
            label: {
                model.icon
            }
        )
        .buttonStyle(.scale)
        .font(.system(size: 24))
        .frame(width: 32, height: 32)
        .foregroundStyle(model.isSelected ? Color.Assets.tintAccent : Color.Assets.tintPrimary)
    }
}
