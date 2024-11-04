//
//  CanvasPlacementView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 04.11.2024.
//


import SwiftUI

import StopMotionDrawing

struct StrokePlacementView: View {
    var stroke: Stroke
    var onSubmit: (CGAffineTransform) -> Void
    
    var body: some View {
        Canvas { context, size in
            context.draw(stroke)
            context.drawDashedBoundingRect(for: stroke, color: .Assets.tintAccentRed, lineWidth: 1.5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(alignment: .topLeading) {
            GeometryReader { proxy in
                Color.clear.onAppear {
                    contentSize = proxy.size
                }
            }
        }
        .transformEffect(transform)
        .gesture(
            TapGesture().onEnded {
                onSubmit(transform)
            }
        )
        .gesture(
            DragGesture()
                .onChanged { value in
                    transform = lastTransform.translatedBy(
                        x: value.translation.width / transform.scaleX,
                        y: value.translation.height / transform.scaleY
                    )
                }
                .onEnded { _ in
                    endGesture()
                }
        )
        .simultaneousGesture(
            RotateGesture()
                .onChanged { value in
                    let newTransform = CGAffineTransform.anchoredRotation(
                        radians: value.rotation.radians,
                        anchor: value.startAnchor.scaledBy(contentSize)
                    )
                    
                    transform = lastTransform.concatenating(newTransform)
                }
                .onEnded { _ in
                    endGesture()
                }
        )
        .simultaneousGesture(
            MagnifyGesture()
                .onChanged { value in
                    let newTransform = CGAffineTransform.anchoredScale(
                        scale: value.magnification,
                        anchor: value.startAnchor.scaledBy(contentSize)
                    )
                    
                    transform = lastTransform.concatenating(newTransform)
                }
                .onEnded { _ in
                    endGesture()
                }
        )
    }
    
    // MARK: - Private
    
    @State private var lastTransform: CGAffineTransform = .identity
    @State private var transform: CGAffineTransform = .identity
    @State private var contentSize: CGSize = .zero
    
    private func endGesture() {
        lastTransform = transform
    }

}


private extension CGAffineTransform {
    static func anchoredScale(scale: CGFloat, anchor: CGPoint) -> CGAffineTransform {
        CGAffineTransform(translationX: anchor.x, y: anchor.y)
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: -anchor.x, y: -anchor.y)
    }
    
    static func anchoredRotation(radians: CGFloat, anchor: CGPoint) -> CGAffineTransform {
        CGAffineTransform(translationX: anchor.x, y: anchor.y)
            .rotated(by: radians)
            .translatedBy(x: -anchor.x, y: -anchor.y)
    }

    var scaleX: CGFloat {
        sqrt(a * a + c * c)
    }

    var scaleY: CGFloat {
        sqrt(b * b + d * d)
    }
}


private extension CGRect {
    var mid: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}

private extension UnitPoint {
    func scaledBy(_ size: CGSize) -> CGPoint {
        .init(
            x: x * size.width,
            y: y * size.height
        )
    }
}
