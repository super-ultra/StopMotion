//
//  ScaleButtonStyle.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 02.11.2024.
//

import SwiftUI

public struct ScaleButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.linear(duration: 0.2), value: configuration.isPressed)
            .brightness(configuration.isPressed ? -0.05 : 0)
    }
}

public extension ButtonStyle where Self == ScaleButtonStyle {
    public static var scale: ScaleButtonStyle {
        ScaleButtonStyle()
    }
}
