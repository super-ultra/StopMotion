//
//  LayerGenerator.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 01.11.2024.
//

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
        return [Layer](repeating: Layer(), count: count)
    }
    
}
