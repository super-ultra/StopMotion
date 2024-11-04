//
//  LayerCollectionViewModelImpl.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 01.11.2024.
//

import CoreGraphics
import Observation
import StopMotionDrawing

@Observable
final class LayerCollectionViewModelImpl: LayerCollectionViewModel {
    
    init(studio: DrawingStudio) {
        self.studio = studio
    }
    
    // MARK: - LayerCollectionViewModel
    
    var itemsCount: Int {
        studio.layersCount
    }
    
    var itemAspectRatio: CGFloat {
        return studio.canvasSize.width / studio.canvasSize.height
    }
    
    func item(at index: Int) -> LayerCollectionItemModel {
        LayerCollectionItemModel(
            layer: studio.layer(at: index), index: "\(index + 1)", isSelected: index == studio.currentLayerIndex
        )
    }
    
    func selectItem(at index: Int) {
        studio.selectLayer(at: index)
    }
        
    // MARK: - Private
    
    private let studio: DrawingStudio
    
}
