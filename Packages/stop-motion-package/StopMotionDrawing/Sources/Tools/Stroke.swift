//
//  Stroke.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 30.10.2024.
//

import SwiftUI

public struct Stroke: Sendable {
    public var path: Path
    public var color: Color
    public var tool: DrawingTool
    
    public init(path: Path, color: Color, tool: DrawingTool) {
        self.path = path
        self.color = color
        self.tool = tool
    }
}
