//
//  Canvas.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 30.10.2024.
//

public struct Layer {
    public var strokes: [Stroke]
    
    public init(strokes: [Stroke] = []) {
        self.strokes = strokes
    }
}
