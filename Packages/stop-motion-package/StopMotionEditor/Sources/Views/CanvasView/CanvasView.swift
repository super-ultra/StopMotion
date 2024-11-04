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
        GeometryReader { geometry in
            Group {
                if isAnimating {
                    animatingCanvas()
                } else {
                    drawingCanvas()
                }
            }
            .onAppear {
                model.updateCanvasSize(geometry.size)
            }
            .onChange(of: geometry.size) { _, newValue in
                model.updateCanvasSize(newValue)
            }
        }
        .overlay {
            placingLayer()
        }
        .onChange(of: zoomViewScale) { _, newValue in
            model.toolScale = zoomViewScale > 0 ? 1 / zoomViewScale : 1
        }
        .clipShape(RoundedRectangle(cornerRadius: Static.cornerRadius))
        .contentShape(RoundedRectangle(cornerRadius: Static.cornerRadius))
    }
    
    // MARK: - Private
    
    private enum Static {
        static let cornerRadius: CGFloat = 20
    }
    
    @State
    private var cursorLocation: CGPoint? = nil
    
    @State
    private var zoomViewScale: CGFloat = 1
    
    @State
    private var zoomViewOffset: CGPoint = .zero
    
    private var zoomTransform: CGAffineTransform {
        CGAffineTransform(translationX: zoomViewOffset.x, y: zoomViewOffset.y)
            .concatenating(CGAffineTransform(scaleX: zoomViewScale, y: zoomViewScale).inverted())
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
                        model.drag(value.location)
                        onDraw()
                    }
                    .onEnded { value in
                        cursorLocation = nil
                        model.endDragging(value.location)
                        onDraw()
                    }
            )
            .onTapGesture { location in
                model.tap(location)
                onDraw()
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

