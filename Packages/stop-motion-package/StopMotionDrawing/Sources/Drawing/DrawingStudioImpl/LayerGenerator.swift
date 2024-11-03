//
//  LayerGenerator.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 01.11.2024.
//

import CoreGraphics
import SwiftUI

struct LayerGenerator {
    
    func generateLayers(basedOn layers: [Layer], fromIndex index: Int, count: Int) -> [Layer] {
        guard count > 0 else { return [] }
        
        if layers.isEmpty {
            return generateNew(count: count)
        }
        
        guard index >= 0, index < layers.count else { return [] }
        
        if layers.count > 1, index < layers.count - 1 {
            return interpolate(from: layers[index], to: layers[index + 1], count: count)
        } else {
            return generate(basedOn: layers[index], count: count)
        }
    }
    
    // MARK: - Private
    
    private func interpolate(from: Layer, to: Layer, count: Int) -> [Layer] {
        return [from, to]
    }
    
    private func generate(basedOn layer: Layer, count: Int) -> [Layer] {
        return [Layer](repeating: layer, count: count)
    }
    
    private func generateNew(count: Int) -> [Layer] {
        let initialLayer = Layer(strokes: [generateStroke()])
        if count == 1 {
            return [initialLayer]
        } else {
            return generate(basedOn: initialLayer, count: count - 1)
        }
    }
    
    private func generateStroke() -> Stroke {
        Stroke(
            path: .random(),
            color: .random(),
            tool: .random()
        )
    }
    
}

extension CGColor {
    static func random() -> CGColor {
        CGColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
}

extension DrawingTool {
    static func random() -> DrawingTool {
        DrawingTool(type: Bool.random() ? .brush : .pencil, size: .random(in: DrawingTool.defaultSizeRange))
    }
}
    
extension Path {
    static func random() -> Path {
//        switch Int.random(in: 0...2) {
//        case 0:
        return .star(x: 0, y: 0, radius: 100, sides: 5, pointiness: 2)
//        }
    }
}