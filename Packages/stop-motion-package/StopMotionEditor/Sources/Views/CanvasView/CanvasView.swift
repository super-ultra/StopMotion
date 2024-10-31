//
//  CanvasView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import SwiftUI

import StopMotionAssets
import StopMotionDrawing



struct CanvasView: View {
    
    @State
    var model: CanvasViewModel
    
    var body: some View {
        Canvas { context, size in
            if let previousLayer = model.previousLayer {
                context.opacity = 0.3
                context.draw(previousLayer)
                context.opacity = 1.0
            }
            
            context.draw(model.currentLayer)
            
            if let cursorLocation {
                context.drawCursor(for: model.tool, color: model.toolColor, location: cursorLocation)
            }
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    cursorLocation = value.location
                    model.drag(value.location)
                }
                .onEnded { value in
                    cursorLocation = nil
                    model.endDragging(value.location)
                }
        )
        .background {
            Image.Assets.canvas
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .cornerRadius(20)
    }
    
    // MARK: - Private
    
    @State
    private var cursorLocation: CGPoint? = nil
}

