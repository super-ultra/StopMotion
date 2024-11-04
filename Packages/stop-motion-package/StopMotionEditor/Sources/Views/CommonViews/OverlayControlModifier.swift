//
//  OverlayControlModifier.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 04.11.2024.
//

import SwiftUI


public struct OverlayControlModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .padding(16)
            .background(
                .ultraThinMaterial,
                in: RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
            .opacity(opacity)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(Animation.interpolatingSpring(duration: 0.25, bounce: 0.5)) {
                    opacity = 1
                    scale = 1
                }
            }
    }
    
    @State
    private var opacity = 0.75
    
    @State
    private var scale = 0.75
}

extension View {
    public func overlayControlBackground() -> some View {
        modifier(OverlayControlModifier())
    }
}
