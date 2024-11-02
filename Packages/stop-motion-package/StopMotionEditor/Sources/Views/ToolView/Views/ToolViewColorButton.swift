//
//  ToolViewColorButton.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import SwiftUI

struct ToolViewColorButtonModel {
    let color: Color
    let isSelected: Bool
    let action: () -> Void
}


struct ToolViewColorButton: View {
    
    let model: ToolViewColorButtonModel
    
    var body: some View {
        Button(
            action: model.action,
            label: {
                Circle()
                    .stroke(model.isSelected ? Color.Assets.tintAccent : Color.Assets.solidGrey, lineWidth: 1.5)
                    .fill(model.color)
                    .frame(width: 28, height: 28)
            }
        )
        .buttonStyle(.scale)
    }
}
