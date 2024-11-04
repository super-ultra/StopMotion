//
//  DrawingTool.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import CoreGraphics

public enum DrawingToolType: CaseIterable, Sendable {
    case pencil
    case brush
    case eraser
}

public struct DrawingTool: Sendable, Equatable {
    public var type: DrawingToolType
    public var size: CGFloat
    
    public init(type: DrawingToolType, size: CGFloat) {
        self.type = type
        self.size = size
    }
}

extension DrawingTool {
    
    public static func `default`(_ type: DrawingToolType) -> DrawingTool {
        switch type {
        case .pencil:
            return DrawingTool(type: .pencil, size: 6)
        case .brush:
            return DrawingTool(type: .brush, size: 16)
        case .eraser:
            return DrawingTool(type: .eraser, size: 24)
        }
    }
    
    public static var defaultSizeRange: ClosedRange<CGFloat> {
        1...48
    }
    
}


extension DrawingTool {
 
    public func scalingSize(with scale: CGFloat) -> DrawingTool {
        DrawingTool(type: type, size: size * scale)
    }
    
}
