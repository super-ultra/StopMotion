//
//  Path+Trinagle.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 03.11.2024.
//

import SwiftUI

extension Path {
    public init(triangleIn rect: CGRect) {
        self.init()
        move(to: CGPoint(x: rect.midX, y: rect.minY))
        addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        addLine(to: CGPoint(x: rect.midX, y: rect.minY))
    }
}
