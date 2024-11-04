//
//  LayerCollectionViewModel.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 01.11.2024.
//

import CoreGraphics
import StopMotionDrawing

@MainActor
protocol LayerCollectionViewModel {
    var itemsCount: Int { get }
    var itemAspectRatio: CGFloat { get }
    func item(at index: Int) -> LayerCollectionItemModel
    func selectItem(at index: Int)
}


struct LayerCollectionViewModelMock: LayerCollectionViewModel {
    var items: [LayerCollectionItemModel]
    
    var itemsCount: Int { items.count }
    
    var itemAspectRatio: CGFloat = 0.55
    
    func item(at index: Int) -> LayerCollectionItemModel {
        items[index]
    }
    
    func selectItem(at index: Int) {}
}
