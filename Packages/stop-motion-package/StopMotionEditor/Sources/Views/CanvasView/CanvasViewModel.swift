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
    
    var animationFPS: Int { get }
    
    func layer(at index: Int) -> Layer
    func drag(_ point: CGPoint)
    func endDragging(_ point: CGPoint)
}
