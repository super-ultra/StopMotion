//
//  LayerCollectionViewModel.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 01.11.2024.
//

import StopMotionDrawing

@MainActor
protocol LayerCollectionViewModel {
    var items: [LayerCollectionItemModel] { get }
    func selectItem(at index: Int)
}


struct LayerCollectionViewModelMock: LayerCollectionViewModel {
    var items: [LayerCollectionItemModel]
    func selectItem(at index: Int) {}
}
