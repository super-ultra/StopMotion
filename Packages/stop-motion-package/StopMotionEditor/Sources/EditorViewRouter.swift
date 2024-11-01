//
//  EditorViewRouter.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 01.11.2024.
//

import SwiftUI
import Observation

import StopMotionDrawing

enum EditorViewDestination: Identifiable {
    case allLayers
    
    // MARK: - Identifiable
    
    var id: Self {
       return self
    }
}


@MainActor
protocol EditorViewRouter: ControlViewRouter, Observable {
    var destination: EditorViewDestination? { get set }
    
    func view(for destination: EditorViewDestination) -> LayerCollectionView
}

@Observable
final class EditorViewRouterImpl: EditorViewRouter {
    
    init(studio: Studio) {
        self.studio = studio
    }
    
    // MARK: - EditorViewRouter
    
    var destination: EditorViewDestination? = nil

    func presentAllLayers() {
        destination = .allLayers
    }
    
    func view(for destination: EditorViewDestination) -> LayerCollectionView {
        switch destination {
        case .allLayers:
            return LayerCollectionView(model: LayerCollectionViewModelImpl(studio: studio))
        }
        
    }
    
    // MARK: - Private
    
    private let studio: Studio
}
