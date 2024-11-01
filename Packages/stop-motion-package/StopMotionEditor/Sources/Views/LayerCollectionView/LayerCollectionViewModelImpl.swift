//
//  LayerCollectionViewModelImpl.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 01.11.2024.
//

import Observation
import StopMotionDrawing

@Observable
final class LayerCollectionViewModelImpl: LayerCollectionViewModel {
    
    init(studio: Studio) {
        self.studio = studio
        self.items = studio.layers.enumerated().map { index, layer in
            LayerCollectionItemModel(
                layer: layer, index: "\(index + 1)", isSelected: index == studio.currentLayerIndex
            )
        }
    }
    
    // MARK: - LayerCollectionViewModel
    
    let items: [LayerCollectionItemModel]
    
    func selectItem(at index: Int) {
        studio.selectLayer(at: index)
    }
        
    // MARK: - Private
    
    private let studio: Studio
    
}
