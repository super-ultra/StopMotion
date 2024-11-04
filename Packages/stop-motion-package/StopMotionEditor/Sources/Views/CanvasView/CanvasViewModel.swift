//
//  CanvasViewModel.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 30.10.2024.
//

import CoreGraphics
import Observation
import SwiftUI

import StopMotionDrawing


@MainActor
protocol CanvasViewModel: Observable {
    var currentLayer: Layer { get }
    var previousLayer: Layer? { get }
    var layersCount: Int { get }
        
    var tool: DrawingTool { get }
    var toolColor: Color { get }
    var toolScale: CGFloat { get set }
    
    var animationFPS: Int { get }
    
    var placingStroke: Stroke? { get }
    
    func layer(at index: Int) -> Layer
    
    func updateCanvasSize(_ size: CGSize)
    
    func drag(_ point: CGPoint)
    func endDragging(_ point: CGPoint)
    func tap(_ point: CGPoint)
    
    func placeShape(_ shape: ShapeType)
    func submitStrokePlacement(transform: CGAffineTransform)
}
