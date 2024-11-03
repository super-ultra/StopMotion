//
//  EditorViewRouter.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 01.11.2024.
//

import SwiftUI
import Observation

import StopMotionDrawing
import StopMotionToolbox

enum EditorViewDestination: Hashable, Identifiable {
    case allLayers
    case sharing(url: URL)
    
    // MARK: - Identifiable
    
    var id: Self {
       return self
    }
}


@MainActor
protocol EditorViewRouter: ControlViewRouter, Observable {
    var destination: EditorViewDestination? { get set }
    
    func view(for destination: EditorViewDestination) -> AnyView
}

@Observable
@MainActor
final class EditorViewRouterImpl: EditorViewRouter {
    
    init(studio: DrawingStudio) {
        self.studio = studio
    }
    
    // MARK: - EditorViewRouter
    
    var destination: EditorViewDestination? = nil

    func presentAllLayers() {
        destination = .allLayers
    }
    
    func share(url: URL) {
        destination = .sharing(url: url)
    }
    
    func view(for destination: EditorViewDestination) -> AnyView {
        switch destination {
        case .allLayers:
            return AnyView(NavigationView {
                LayerCollectionView(model: LayerCollectionViewModelImpl(studio: studio))
            })
        case .sharing(let url):
            // ActivityView is used due to lazy initialization
            return AnyView(ActivityView(activityItems: [url]))
        }
    }
    
    // MARK: - Private
    
    private let studio: DrawingStudio
}
