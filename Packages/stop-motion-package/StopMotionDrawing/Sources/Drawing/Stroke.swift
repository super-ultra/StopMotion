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
    public var transform: CGAffineTransform
    
    public init(path: Path, color: CGColor, tool: DrawingTool, transform: CGAffineTransform = .identity) {
        self.path = path
        self.color = color
        self.tool = tool
        self.transform = transform
    }
}

extension Stroke {
    public func applying(_ transform: CGAffineTransform) -> Stroke {
        Stroke(path: path, color: color, tool: tool, transform: self.transform.concatenating(transform))
    }
}
