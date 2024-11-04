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
    
    public var rotation: CGFloat {
        atan2(b, a)
    }

    public static func anchoredScale(scale: CGFloat, anchor: CGPoint) -> CGAffineTransform {
        .anchoredScale(x: scale, y: scale, anchor: anchor)
    }
    
    public static func anchoredScale(x: CGFloat, y: CGFloat, anchor: CGPoint) -> CGAffineTransform {
        CGAffineTransform(translationX: anchor.x, y: anchor.y)
            .scaledBy(x: x, y: y)
            .translatedBy(x: -anchor.x, y: -anchor.y)
    }
    
    public static func anchoredRotation(radians: CGFloat, anchor: CGPoint) -> CGAffineTransform {
        CGAffineTransform(translationX: anchor.x, y: anchor.y)
            .rotated(by: radians)
            .translatedBy(x: -anchor.x, y: -anchor.y)
    }
    
}
