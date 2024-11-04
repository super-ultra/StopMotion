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
        return generate(basedOn: from, count: count, canvasSize: canvasSize)
    }
    
    private func generate(basedOn baseLayer: Layer, count: Int, canvasSize: CGSize) -> [Layer] {
        var result: [Layer] = [baseLayer]
        
        for _ in 0..<count {
            guard let base = result.last else { break }
            let newLayer = Layer(
                strokes: base.strokes.map { stroke in
                    stroke
                        .applying(
                            CGAffineTransform(scaleX: .random(in: 0.9...1.1), y: .random(in: 0.9...1.1))
                        )
                        .applying(
                            CGAffineTransform(rotationAngle: .random(in: -(.pi/16)...(.pi/16)))
                        )
                        .applying(
                            CGAffineTransform(translationX: .random(in: -16...16), y: .random(in: -16...16))
                        )
                }
            )
            
            result.append(newLayer)
        }
        
        return result
    }
    
    private func generateNew(count: Int, canvasSize: CGSize) -> [Layer] {
        let initialLayer: Layer = .random(canvasSize: canvasSize)
        
        if count == 1 {
            return [initialLayer]
        } else {
            return generate(basedOn: initialLayer, count: count - 1, canvasSize: canvasSize)
        }
    }
    
}

// MARK: - Utils

extension CGColor {
    fileprivate static func random() -> CGColor {
        CGColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
}

extension DrawingTool {
    fileprivate static func random() -> DrawingTool {
        DrawingTool(type: Bool.random() ? .brush : .pencil, size: .random(in: DrawingTool.defaultSizeRange))
    }
}
    
extension Path {
    fileprivate static func random(canvasSize: CGSize) -> Path {
        guard canvasSize.width > 0, canvasSize.height > 0 else {
            assertionFailure()
            return Path()
        }
        
        let rect = CGRect(
            x: 0,
            y: 0,
            width: .random(in: canvasSize.width / 4...canvasSize.width / 2),
            height: .random(in: canvasSize.height / 4...canvasSize.width / 2)
        )
        
        switch ShapeType.random() {
        case .circle:
            return Path(ellipseIn: rect)
        case .square:
            return Path(rect)
        case .triangle:
            return Path(triangleIn: rect)
        case .star:
            return Path(starIn: rect, sides: .random(in: 3...10), pointiness: .random(in: 1.5...3))
        }
    }
}

extension CGAffineTransform {
    
    fileprivate static func random(canvasSize: CGSize) -> CGAffineTransform {
        let scaleValue: CGFloat = .random(in: 0.8...1.5)
        let scale = CGAffineTransform(scaleX: scaleValue, y: scaleValue)
        
        let rotation = CGAffineTransform(rotationAngle: .random(in: 0...2 * CGFloat.pi))
        
        let translation = CGAffineTransform(
            translationX: .random(in: 0...canvasSize.width),
            y: .random(in: 0...canvasSize.height)
        )
        
        return scale.concatenating(rotation).concatenating(translation)
    }
        
}

extension Stroke {
    
    fileprivate static func random(canvasSize: CGSize) -> Stroke {
        return Stroke(
            path: .random(canvasSize: canvasSize),
            color: .random(),
            tool: .random(),
            transform: .random(canvasSize: canvasSize)
        )
    }
    
}


extension Layer {
    
    fileprivate static func random(canvasSize: CGSize) -> Layer {
        let count: Int = .random(in: 1...3)
        return Layer(strokes: (0..<count).map { _ in .random(canvasSize: canvasSize) })
    }
    
}
