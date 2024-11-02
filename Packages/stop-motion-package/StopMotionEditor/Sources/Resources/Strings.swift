//
//  Strings.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 01.11.2024.
//

import Foundation


enum Strings {
    enum Common {
        static let ok = String(localized: "Ok")
        static let cancel = String(localized: "Cancel")
        static let close = String(localized: "Close")
    }
    
    enum ControlView {
        static let generateLayersTitle = String(localized: "Generate layers")
        static let generateLayersMessage = String(localized: "Enter the number of layers to generate..")
        static let fps = String(localized: "FPS")
    }
    
    enum DeleteAllLayersAlert {
        static let message = String(localized: "Are you sure you want to delete all layers?")
        static let deleteAll = String(localized: "Delete All Layers")
    }
    
    enum LayersCollectionView {
        static let allLayers = String(localized: "All Layers")
    }
}
