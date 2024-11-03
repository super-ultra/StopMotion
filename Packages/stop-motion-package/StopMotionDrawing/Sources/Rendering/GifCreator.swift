//
//  GifCreator.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 03.11.2024.
//


import Foundation
import ImageIO
import UniformTypeIdentifiers
import UIKit

public enum GifCreatorErrors: Error {
    case createFile
    case noLayers
    case negativeFps
}

public struct GifCreator {
    
    public init() {}

    public func generateGif(for layers: [Layer], background: CGImage? = nil, size: CGSize, fps: Int, filename: String) async throws -> URL {
        guard !layers.isEmpty else {
            throw GifCreatorErrors.noLayers
        }
        guard fps > 0 else {
            throw GifCreatorErrors.negativeFps
        }
        
        let destinationURL = generateUrl(filename: filename)
        let animatedGifFile = try makeFile(at: destinationURL, layers: layers)
        
        // Render layers
        let gifProperties = [kCGImagePropertyGIFDictionary: [kCGImagePropertyGIFDelayTime: 1.0 / CGFloat(fps)]]
        
        let imageFormat = UIGraphicsImageRendererFormat()
        imageFormat.scale = 2.0
        imageFormat.opaque = false
        
        for layer in layers {
            let renderer = UIGraphicsImageRenderer(size: size, format: imageFormat)
            
            let image = renderer.image {
                $0.cgContext.draw(layer, background: background)
            }.cgImage

            if let image {
                CGImageDestinationAddImage(animatedGifFile, image, gifProperties as CFDictionary)
            }
        }
        
        CGImageDestinationFinalize(animatedGifFile)
        
        return destinationURL
    }
    
    
    // MARK: - Private
    
    private func generateUrl(filename: String) -> URL {
        return URL.temporaryDirectory
            .appendingPathComponent(filename)
            .appendingPathExtension(UTType.gif.identifier)
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
