//
//  LayerGenerator.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 01.11.2024.
//

import CoreGraphics
import SwiftUI

struct LayerGenerator {
    
    func generateLayers(basedOn layers: [Layer], fromIndex index: Int, count: Int, canvasSize: CGSize) -> [Layer] {
        guard count > 0 else { return [] }
        
        if layers.isEmpty {
            return generateNew(count: count, canvasSize: canvasSize)
        }
        
        guard index >= 0, index < layers.count else { return [] }
        
        if layers.count > 1, index < layers.count - 1 {
            return interpolate(from: layers[index], to: layers[index + 1], count: count, canvasSize: canvasSize)
        } else {
            return generate(basedOn: layers[index], count: count, canvasSize: canvasSize)
        }
    }
    
    // MARK: - Private
    
    private func interpolate(from: Layer, to: Layer, count: Int, canvasSize: CGSize) -> [Layer] {
        return [from, to]
    }
    
    private func generate(basedOn layer: Layer, count: Int, canvasSize: CGSize) -> [Layer] {
        return [Layer](repeating: layer, count: count)
    }
    
    private func generateNew(count: Int, canvasSize: CGSize) -> [Layer] {
        let initialLayer = Layer(strokes: [generateStroke()])
        if count == 1 {
            return [initialLayer]
        } else {
            return generate(basedOn: initialLayer, count: count - 1, canvasSize: canvasSize)
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
        switch ShapeType.random() {
        case .circle:
            return Path(ellipseIn: CGRect())
        case .square:
            return Path(CGRect())
        case .triangle:
            return Path(triangleIn: CGRect())
        case .star:
            return .star(x: 0, y: 0, radius: 100, sides: 5, pointiness: 2)
        }
    }
}
