//
//  Strings.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 01.11.2024.
//

import Foundation


enum Strings {
    enum Common {
        static let ok = String(localized: "Ok", bundle: .module)
        static let cancel = String(localized: "Cancel", bundle: .module)
        static let close = String(localized: "Close", bundle: .module)
    }
    
    enum ControlView {
        static let generateLayersTitle = String(localized: "Generate layers", bundle: .module)
        static let generateLayersMessage = String(localized: "Enter the number of layers to generate.", bundle: .module)
        static let sharingErrorMessage = String(localized: "Failed to generate GIF.", bundle: .module)
    }
    
    enum DeleteAllLayersAlert {
        static let message = String(localized: "Are you sure you want to delete all layers?", bundle: .module)
        static let deleteAll = String(localized: "Delete All Layers", bundle: .module)
    }
    
    enum LayersCollectionView {
        static let allLayers = String(localized: "All Layers", bundle: .module)
    }
    
    enum FpsSliderView {
        static func fps(_ count: Int) -> String { String(localized: "\(count) FPS", bundle: .module) }
    }
}
