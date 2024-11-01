//
//  DrawingTool.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import CoreGraphics

public enum DrawingToolType: Sendable {
    case pencil
    case eraser
}

public struct DrawingTool: Sendable, Equatable {
    public var type: DrawingToolType
    public var size: CGFloat
    
    public init(type: DrawingToolType, size: CGFloat) {
        self.type = type
        self.size = size
    }
    
    public static func `default`(_ type: DrawingToolType) -> DrawingTool {
        switch type {
        case .pencil:
            return DrawingTool(type: .pencil, size: 8)
        case .eraser:
            return DrawingTool(type: .eraser, size: 16)
        }
    }
    
}
