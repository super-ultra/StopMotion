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
        .overlay {
            placingLayer()
        }
        .cornerRadius(20)
    }
    
    // MARK: - Private
    
    @State
    private var cursorLocation: CGPoint? = nil
    
    @State
    private var zoomViewScale: CGFloat = 1
    
    @State
    private var zoomViewOffset: CGPoint = .zero
    
    private var zoomTransform: CGAffineTransform {
        CGAffineTransform(translationX: zoomViewOffset.x, y: zoomViewOffset.y)
            .concatenating(CGAffineTransform(scaleX: 1.0 / zoomViewScale, y: 1.0 / zoomViewScale))
    }

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
            },
            scale: $zoomViewScale,
            offset: $zoomViewOffset
        ) {
            Canvas { context, size in
                context.draw(model.currentLayer)
                
                if let cursorLocation {
                    context.drawCursor(
                        for: model.tool,
                        color: model.toolColor,
                        location: cursorLocation,
                        scale: zoomViewScale
                    )
                }
            }
            .highPriorityGesture(
                DragGesture(minimumDistance: 2)
                    .onChanged { value in
                        cursorLocation = value.location
                        model.toolScale = 1 / zoomViewScale
                        model.drag(value.location)
                        onDraw()
                    }
                    .onEnded { value in
                        cursorLocation = nil
                        model.toolScale = 1 / zoomViewScale
                        model.endDragging(value.location)
                        onDraw()
                    }
            )
            .onTapGesture { location in
                model.toolScale = 1 / zoomViewScale
                model.tap(location)
            }
            .background {
                previousLayer()
            }
            .background {
                canvasBackground()
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
                model.submitStrokePlacement(transform: transform.concatenating(zoomTransform))
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

