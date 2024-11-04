//
//  CanvasPlacementView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 04.11.2024.
//


import SwiftUI

import StopMotionDrawing
import StopMotionToolbox

struct StrokePlacementView: View {
    var stroke: Stroke
    var onSubmit: (CGAffineTransform) -> Void
    
    var body: some View {
        Group {
            Canvas { context, size in
                context.transform = transform
                context.draw(stroke)
                
                context.drawBoundingRect(
                    for: stroke,
                    color: .Assets.tintAccent,
                    lineWidth: transform.scaleX > 0 ? 1.5 / transform.scaleX : 1.0
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            onSubmit(transform)
        }
        .simultaneousGesture(
            DragGesture()
                .onChanged { value in
                    guard value.translation.width.isFinite, value.translation.height.isFinite else { return }
                    
                    let newTransform = CGAffineTransform(
                        translationX: value.translation.width,
                        y: value.translation.height
                    )
                    translation = lastTranslation.concatenating(newTransform)
                }
                .onEnded { _ in
                    endGesture()
                }
        )
        .simultaneousGesture(
            MagnifyGesture()
                .onChanged { value in
                    guard value.magnification.isFinite, value.magnification > 0 else { return }
                    
                    let newTransform = CGAffineTransform.anchoredScale(
                        scale: value.magnification,
                        anchor: stroke.path.boundingRect.mid
                    )
                    
                    rotation = lastRotation.concatenating(newTransform)
                }
                .onEnded { _ in
                    endGesture()
                }
        )
        .simultaneousGesture(
            RotateGesture()
                .onChanged { value in
                    guard value.rotation.radians.isFinite else { return }
                    
                    let newTransform = CGAffineTransform.anchoredRotation(
                        radians: value.rotation.radians,
                        anchor: stroke.path.boundingRect.mid
                    )
                    
                    scale = lastScale.concatenating(newTransform)
                }
                .onEnded { _ in
                    endGesture()
                }
        )
    }
    
    // MARK: - Private
    
    @State private var lastTranslation: CGAffineTransform = .identity
    @State private var translation: CGAffineTransform = .identity
    
    @State private var lastRotation: CGAffineTransform = .identity
    @State private var rotation: CGAffineTransform = .identity
    
    @State private var lastScale: CGAffineTransform = .identity
    @State private var scale: CGAffineTransform = .identity
        
    private var transform: CGAffineTransform {
        scale.concatenating(rotation).concatenating(translation)
    }
    
    private func endGesture() {
        lastTranslation = translation
        lastRotation = rotation
        lastScale = scale
    }

}

