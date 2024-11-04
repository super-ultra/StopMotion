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
                let path = stroke.path.applying(stroke.transform)
                let translationX = -path.boundingRect.midX
                let translationY = -path.boundingRect.midY
                let transition = CGAffineTransform(translationX: translationX, y: translationY)
                
                return Stroke(
                    path: path.applying(transition),
                    color: stroke.color,
                    tool: stroke.tool.scalingSize(with: stroke.transform.decomposed().scale.width),
                    transform: transition.inverted()
                )
            }
        )
    }
    
}
