//
//  CanvasView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import SwiftUI

import StopMotionAssets


struct CanvasView: View {
    var body: some View {
        Canvas { _, _ in
            
        }
        .background {
            Image.Assets.canvas
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .cornerRadius(20)
    }
}
