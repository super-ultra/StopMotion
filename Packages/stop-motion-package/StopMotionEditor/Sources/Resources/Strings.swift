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
    }
    
    enum ControlView {
        static let generateLayersTitle = String(localized: "Generate layers")
        static let generateLayersMessage = String(localized: "Enter the number of layers to generate..")
    }
    
    enum DeleteAllLayersAlert {
        static let message = String(localized: "Are you sure you want to delete all layers?")
        static let deleteAll = String(localized: "Delete All Layers")
    }
}
