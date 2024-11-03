//
//  Clamp.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 03.11.2024.
//

import Foundation

extension Comparable {
    public func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
