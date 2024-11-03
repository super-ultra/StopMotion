//
//  GifCreator.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 03.11.2024.
//


import Foundation
import ImageIO
import UniformTypeIdentifiers
import SwiftUI


public enum GifCreatorErrors: Error {
    case createFile
    case noLayers
    case negativeFps
}

public struct GifCreator {
    
    public init() {}

    @MainActor
    public func generateGif(for layers: [Layer], size: CGSize, fps: Int) throws -> URL {
        guard !layers.isEmpty else {
            throw GifCreatorErrors.noLayers
        }
        guard fps > 0 else {
            throw GifCreatorErrors.negativeFps
        }
        
        let destinationURL = generateUrl()
        let animatedGifFile = try makeFile(at: destinationURL, layers: layers)
        
        // Render layers
        let properties = [kCGImagePropertyGIFDictionary: [kCGImagePropertyGIFDelayTime: 1.0 / CGFloat(fps)]]
        
        for layer in layers {
            let image = ImageRenderer(
                content: Canvas { context, size in
                    context.draw(layer)
                }.frame(width: size.width, height: size.height)
            ).cgImage
            
            if let image {
                CGImageDestinationAddImage(animatedGifFile, image, properties as CFDictionary)
            }
        }
        
        CGImageDestinationFinalize(animatedGifFile)
        
        return destinationURL
    }
    
    
    // MARK: - Private
    
    private func generateUrl() -> URL {
        let destinationFilename = String(UUID().uuidString + ".gif")
        return URL.temporaryDirectory.appendingPathComponent(destinationFilename)
    }
    
    private func makeFile(at url: URL, layers: [Layer]) throws -> CGImageDestination {
        let fileDictionary = [kCGImagePropertyGIFDictionary: [kCGImagePropertyGIFLoopCount: 0]]
        
        guard let animatedGifFile = CGImageDestinationCreateWithURL(url as CFURL, UTType.gif.identifier as CFString, layers.count, nil) else {
            throw GifCreatorErrors.createFile
        }
        
        CGImageDestinationSetProperties(animatedGifFile, fileDictionary as CFDictionary)
        
        return animatedGifFile
    }
    
}
