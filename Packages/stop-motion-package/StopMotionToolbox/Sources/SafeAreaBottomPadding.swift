//
//  DrawingTool.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import SwiftUI

public struct SafeAreaBottomPadding: ViewModifier {
    public func body(content: Content) -> some View {
        if UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 {
            content.padding(.bottom)
        } else {
            content
        }
    }
}

extension View {
    public func safeAreaBottomPadding() -> some View {
        modifier(SafeAreaBottomPadding())
    }
}
