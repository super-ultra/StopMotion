//
//  Stroke.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 30.10.2024.
//

import SwiftUI

public struct Stroke: Sendable {
    public var path: Path
    public var color: CGColor
    public var tool: DrawingTool
    
    public init(path: Path, color: CGColor, tool: DrawingTool) {
        self.path = path
        self.color = color
        self.tool = tool
    }
}

extension Stroke {
    public func applying(_ transform: CGAffineTransform) -> Stroke {
        Stroke(path: path.applying(transform), color: color, tool: tool)
    }
}
