//
//  CGAffineTransform+Utils.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 04.11.2024.
//

import CoreGraphics

extension CGAffineTransform {
    
    public var scaleX: CGFloat {
        sqrt(a * a + c * c)
    }

    public var scaleY: CGFloat {
        sqrt(b * b + d * d)
    }
    
    public static func anchoredScale(scale: CGFloat, anchor: CGPoint) -> CGAffineTransform {
        CGAffineTransform(translationX: anchor.x, y: anchor.y)
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: -anchor.x, y: -anchor.y)
    }
    
    public static func anchoredRotation(radians: CGFloat, anchor: CGPoint) -> CGAffineTransform {
        CGAffineTransform(translationX: anchor.x, y: anchor.y)
            .rotated(by: radians)
            .translatedBy(x: -anchor.x, y: -anchor.y)
    }
    
}
