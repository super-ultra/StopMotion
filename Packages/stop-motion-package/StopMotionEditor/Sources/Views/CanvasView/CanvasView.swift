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
    
    let isAnimating: Bool
    
    let onDraw: () -> Void
    
    var body: some View {
        Group {
            if isAnimating {
                animatingCanvas()
            } else {
                drawingCanvas()
            }
        }
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
    
    @ViewBuilder
    private func animatingCanvas() -> some View {
        let initialDate = Date()
        let interval: TimeInterval = 1.0 / Double(model.animationFPS)
        
        TimelineView(.periodic(from: initialDate, by: interval)) { timeContext in
            Canvas { context, size in
                let index = Int(timeContext.date.timeIntervalSince(initialDate) / interval) % model.layers.count
                context.draw(model.layers[index])
            }
        }
    }
    
    @ViewBuilder
    private func drawingCanvas() -> some View {
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
                    onDraw()
                }
                .onEnded { value in
                    cursorLocation = nil
                    model.endDragging(value.location)
                    onDraw()
                }
        )
    }
}

