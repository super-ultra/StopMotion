//
//  CanvasView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import SwiftUI

import StopMotionAssets
import StopMotionDrawing
import StopMotionToolbox


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
                let index = Int(timeContext.date.timeIntervalSince(initialDate) / interval) % model.layersCount
                context.draw(model.layer(at: index))
            }
        }
        .background {
            canvasBackground()
        }
    }
    
    @ViewBuilder
    private func drawingCanvas() -> some View {
        ZoomView(
            minZoom: 1,
            maxZoom: 10,
            bounces: false,
            onGesture: {
                cursorLocation = nil
            }
        ) {
            Canvas { context, size in
                context.draw(model.currentLayer)
                
                if let cursorLocation {
                    context.drawCursor(for: model.tool, color: model.toolColor, location: cursorLocation)
                }
            }
            .highPriorityGesture(
                DragGesture(minimumDistance: 2)
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
            .background {
                previousLayer()
            }
            .background {
                canvasBackground()
            }
            .allowsHitTesting(model.placingStroke != nil)
            .overlay {
                placingLayer()
            }
        }
    }
    
    @ViewBuilder
    private func previousLayer() -> some View {
        Canvas { context, size in
            guard let previousLayer = model.previousLayer else { return }
            context.opacity = 0.3
            context.draw(previousLayer)
            context.opacity = 1.0
        }
    }
    
    @ViewBuilder
    private func placingLayer() -> some View {
        if let stroke = model.placingStroke {
            StrokePlacementView(stroke: stroke, onSubmit: { transform in
                model.submitStrokePlacement(transform: transform)
            })
        }
        
    }
    
    @ViewBuilder
    private func canvasBackground() -> some View {
        Image.Assets.canvas
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
}

