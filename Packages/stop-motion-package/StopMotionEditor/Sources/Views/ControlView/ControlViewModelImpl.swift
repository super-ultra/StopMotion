//
//  ControlViewModelImpl.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 29.10.2024.
//

import Observation
import SwiftUI
import StopMotionDrawing
import StopMotionAssets


@MainActor
@Observable
final class ControlViewModelImpl: ControlViewModel {
    
    init(studio: DrawingStudio, settings: EditorSettings, router: ControlViewRouter) {
        self.studio = studio
        self.settings = settings
        self.router = router
    }
    
    // MARK: - ControlViewModel
    
    var isUndoAvailable: Bool { studio.isUndoAvailable }
    
    var isRedoAvailable: Bool { studio.isRedoAvailable }
    
    var isDeleteAvailable: Bool { studio.layersCount > 1 || !studio.currentLayer.strokes.isEmpty }
    
    var isPlayAvailable: Bool { studio.layersCount > 1 }
    
    private(set) var isPlaying: Bool = false
    
    var layerCounter: String {
        return "\(studio.currentLayerIndex + 1) / \(studio.layersCount)"
    }
    
    private(set) var sharingState: ControlButtonState = .available
    
    var generateState: ControlButtonState {
        return studio.isLayersGenerating ? .loading : .available
    }
    
    private(set) var errorState: ControlViewErrorState? = nil
    
    func undo() {
        studio.undo()
    }
    
    func redo() {
        studio.redo()
    }
    
    func deleteLayer() {
        studio.deleteCurrentLayer()
    }
    
    func deleteAllLayers() {
        studio.deleteAllLayers()
    }
    
    func makeNewLayer() {
        studio.makeNewLayer()
    }
    
    func duplicateLayer() {
        studio.duplicateLayer()
    }
    
    func generateLayers(count: Int) {
        studio.generateLayers(count: count)
    }
    
    func presentAllLayers() {
        router.presentAllLayers()
    }
    
    func play() {
        guard isPlayAvailable, !isPlaying else {
            return
        }
        isPlaying = true
    }
    
    func pause() {
        guard isPlaying else {
            return
        }
        isPlaying = false
        
        sharingTask?.cancel()
        sharingTask = nil
    }
    
    func share() {
        sharingState = .loading
        
        let generator = GifCreator()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd--HH-mm-ss"
            
        sharingTask = Task {
            do {
                let url = try await generator.generateGif(
                    for: studio.getAllLayers(),
                    background: UIImage.Assets.canvas.cgImage,
                    size: studio.canvasSize,
                    fps: settings.animationFPS,
                    filename: "animation-\(formatter.string(from: .now))"
                )
                
                await MainActor.run {
                    router.share(url: url)
                    
                    sharingState = .available
                }
            } catch {
                let message = Task.isCancelled ? Strings.ControlView.sharingCancelledMessage : Strings.ControlView.sharingErrorMessage
                
                errorState = ControlViewErrorState(
                    message: message,
                    onDismiss: { [weak self] in
                        self?.errorState = nil
                        self?.sharingState = .available
                    }
                )
            }
        }
    }
    
    // MARK: - Private
    
    private let studio: DrawingStudio
    private let settings: EditorSettings
    private let router: ControlViewRouter
    private var sharingTask: Task<Void, Never>?
}
