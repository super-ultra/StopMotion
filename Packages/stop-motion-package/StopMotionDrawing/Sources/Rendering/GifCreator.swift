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
    case createGraphicsContext
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
        
        let scale: CGFloat = 2.0
        
        guard let bitmapContext = CGContext.make(size: size, scale: scale) else {
            throw GifCreatorErrors.createGraphicsContext
        }
        
        for layer in layers {
            try Task.checkCancellation()
            
            bitmapContext.saveGState()
            bitmapContext.draw(layer, size: size, background: background)
            bitmapContext.restoreGState()

            if let image = bitmapContext.makeImage() {
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

// MARK: - Private

extension CGContext {
    
    fileprivate static func make(size: CGSize, scale: CGFloat) -> CGContext? {
        let context = CGContext(
            data: nil,
            width: Int(size.width * scale),
            height: Int(size.height * scale),
            bitsPerComponent: 8,
            bytesPerRow: computeBytesPerRow(size: size, scale: scale),
            space: CGColorSpace(name: CGColorSpace.sRGB)!,
            bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue
        )
        
        context?.scaleBy(x: scale, y: scale)
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1, y: -1)
        
        return context
    }
    
    
    private static func computeBytesPerRow(size: CGSize, scale: CGFloat) -> Int {
        return (((Int(size.width * scale * 4)) + 15) / 16) * 16
    }
}
