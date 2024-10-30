//
//  CanvasViewModel.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 30.10.2024.
//

import CoreGraphics
import Observation

import StopMotionDrawing


@MainActor
protocol CanvasViewModel: Observable {
    var layer: Layer { get }
    
    func drag(_ point: CGPoint)
    func endDragging(_ point: CGPoint)
}
