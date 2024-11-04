//
//  LayerGenerator.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 01.11.2024.
//

import CoreGraphics
import SwiftUI

struct LayerGenerator {
    
    func generateLayers(basedOn layers: [Layer], fromIndex index: Int, count: Int, canvasSize: CGSize) async -> [Layer] {
        guard count > 0 else { return [] }
        
        if layers.isEmpty {
            return generateNew(count: count, canvasSize: canvasSize)
        }
        
        guard index >= 0, index < layers.count else { return [] }
        
        return generateLayers(basedOn: layers[index], count: count, canvasSize: canvasSize, appendingNewStrokes: true)
    }
    
    // MARK: - Private
    
    private func generateNew(count: Int, canvasSize: CGSize) -> [Layer] {
        let initialLayer: Layer = .random(canvasSize: canvasSize)
        
        if count == 1 {
            return [initialLayer]
        } else {
            return [initialLayer] + generateLayers(basedOn: initialLayer, count: count - 1, canvasSize: canvasSize)
        }
    }
    
    private func generateLayers(basedOn baseLayer: Layer, count: Int, canvasSize: CGSize, appendingNewStrokes: Bool = false) -> [Layer] {
        guard count > 0 else {
            return []
        }
        
        // Normalize layer to apply correct transforms
        let normalizedBaseLayer = baseLayer.normalized()
        
        guard count > 1 else {
            return generateLayers(
                basedOn: normalizedBaseLayer,
                count: count,
                destinations: normalizedBaseLayer.strokes.map { stroke in
                    .random(pathBounds: stroke.path.boundingRect, canvasSize: canvasSize)
                }
            )
        }
        
        // Add stroke if needed
        let updatedBaseLayer = appendingNewStrokes
            ? normalizedBaseLayer.appendingRandomStrokes(count: .random(in: 0...2), canvasSize: canvasSize)
            : normalizedBaseLayer
        
        // Steps for random trajectory
        let stepThreshold = 20
        let stepsCount = (count + stepThreshold - 1) / stepThreshold + 1
        let singleStep = count / stepsCount
        
        var result: [Layer] = []
        
        for _ in 0..<stepsCount - 1 {
            let stepTransforms: [CGAffineTransform] = updatedBaseLayer.strokes.map { stroke in
                return .random(pathBounds: stroke.path.boundingRect, canvasSize: canvasSize)
            }
            
            result += generateLayers(basedOn: result.last ?? updatedBaseLayer, count: singleStep, destinations: stepTransforms)
        }
        
        
        // Return to the initial position
        let countLeft = count - (stepsCount - 1) * singleStep
        let initialTransforms: [CGAffineTransform] = updatedBaseLayer.strokes.map { $0.transform }
        result += generateLayers(basedOn: result.last ?? updatedBaseLayer, count: countLeft, destinations: initialTransforms)
        
        return result
    }
    
    private func generateLayers(basedOn baseLayer: Layer, count: Int, destinations: [CGAffineTransform]) -> [Layer] {
        var result: [Layer] = []
        
        for i in 0..<count {
            let base = result.last ?? baseLayer
            let step = CGFloat(count - i)
            
            let newLayer = Layer(
                strokes: base.strokes.enumerated().map { offset, stroke in
                    var x = stroke.transform.tx + .random(in: -5...5)
                    x += (destinations[offset].tx - x) / step
                    
                    var y = stroke.transform.ty + .random(in: -5...5)
                    y += (destinations[offset].ty - y) / step
                    
                    var rotation = stroke.transform.rotation + .random(in: (-.pi / 32)...(.pi / 32))
                    rotation += (destinations[offset].rotation - rotation) / step
                    
                    var scaleX = stroke.transform.scaleX * .random(in: 0.95...1.05)
                    scaleX += (destinations[offset].scaleX - scaleX) / step
                    
                    var scaleY = stroke.transform.scaleY * .random(in: 0.95...1.05)
                    scaleY += (destinations[offset].scaleY - scaleY) / step
                    
                    return stroke
                        .updating(
                            CGAffineTransform(scaleX: scaleX, y: scaleY)
                                .concatenating(CGAffineTransform(rotationAngle: rotation))
                                .concatenating(CGAffineTransform(translationX: x, y: y))
                        )
                }
            )
            
            result.append(newLayer)
        }
        
        return result
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
        DrawingTool(type: Bool.random() ? .brush : .pencil, size: .random(in: 8...32))
    }
}
    
extension Path {
    fileprivate static func random(canvasSize: CGSize) -> Path {
        guard canvasSize.width > 0, canvasSize.height > 0 else {
            assertionFailure()
            return Path()
        }
        
        let width: CGFloat = .random(in: canvasSize.width / 6...canvasSize.width / 3)
        let height: CGFloat = .random(in: canvasSize.height / 6...canvasSize.height / 3)
        
        let rect = CGRect(
            x: -width / 2,
            y: -height / 2,
            width: width,
            height: height
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
    
    fileprivate static func random(pathBounds: CGRect, canvasSize: CGSize) -> CGAffineTransform {
        let anchor = pathBounds.mid
        
        let scaleValue: CGFloat = .random(in: 0.8...1.2)
        let scale = CGAffineTransform(scaleX: scaleValue, y: scaleValue)
        
        let rotation = CGAffineTransform(rotationAngle: .random(in: 0...2 * CGFloat.pi))
        
        let translation = CGAffineTransform(
            translationX: .random(in: -pathBounds.minX...canvasSize.width - pathBounds.maxX),
            y: .random(in: -pathBounds.minY...canvasSize.height - pathBounds.maxY)
        )
        
        return scale.concatenating(rotation).concatenating(translation)
    }
        
}

extension Stroke {
    
    fileprivate static func random(canvasSize: CGSize) -> Stroke {
        let path = Path.random(canvasSize: canvasSize)
        return Stroke(
            path: path,
            color: .random(),
            tool: .random(),
            transform: .random(pathBounds: path.boundingRect, canvasSize: canvasSize)
        )
    }
    
    fileprivate static func randomSmall(canvasSize: CGSize) -> Stroke {
        var result: Stroke = .random(canvasSize: canvasSize)
        result.transform = CGAffineTransform(scaleX: 0.01, y: 0.01).concatenating(result.transform)
        return result
    }
    
}


extension Layer {
    
    fileprivate static func random(canvasSize: CGSize) -> Layer {
        let count: Int = .random(in: 2...4)
        return Layer(strokes: (0..<count).map { _ in .random(canvasSize: canvasSize) })
    }
    
    fileprivate func appendingRandomStrokes(count: Int, canvasSize: CGSize) -> Layer {
        return self.appending((0..<count).map { _ in .randomSmall(canvasSize: canvasSize) })
    }
    
}
