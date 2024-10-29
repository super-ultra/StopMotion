//
//  EditorModelImpl.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 29.10.2024.
//

@MainActor
final class EditorModelImpl: EditorModel {
    
    init() {
        controlModel = ControlViewModelImpl()
        toolModel = ToolViewModelImpl()
    }
    
    // MARK: - EditorModel
    
    let controlModel: ControlViewModel
    
    let toolModel: ToolViewModel
}
