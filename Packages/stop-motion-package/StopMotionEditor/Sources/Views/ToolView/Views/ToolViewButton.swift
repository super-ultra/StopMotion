//
//  ToolViewButton.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import SwiftUI
import StopMotionAssets


struct ToolViewButtonModel {
    let icon: Image
    let isSelected: Bool
    let action: () -> Void
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
        .foregroundStyle(model.isSelected ? Color.Assets.tintAccent : Color.Assets.tintPrimary)
    }
}
