//
//  Canvas.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 30.10.2024.
//

import CoreGraphics

public struct Layer: Sendable {
    public var strokes: [Stroke]
    
    public init(strokes: [Stroke] = []) {
        self.strokes = strokes
    }
}


extension Layer {
    
    public func appending(_ stroke: Stroke) -> Layer {
        return Layer(strokes: self.strokes + [stroke])
    }
    
    public func appending(_ strokes: [Stroke]) -> Layer {
        return Layer(strokes: self.strokes + strokes)
    }
    
    public func normalized() -> Layer {
        return Layer(
            strokes: strokes.map { stroke in
                let translationX = -stroke.path.boundingRect.midX
                let translationY = -stroke.path.boundingRect.midY
                let transition = CGAffineTransform(translationX: translationX, y: translationY)
                
                return Stroke(
                    path: stroke.path.applying(transition),
                    color: stroke.color,
                    tool: stroke.tool,
                    transform: stroke.transform.concatenating(transition.inverted())
                )
            }
        )
    }
    
}
