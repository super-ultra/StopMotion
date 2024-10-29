//
//  CanvasView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import SwiftUI

import StopMotionAssets
import StopMotionDrawing


protocol CanvasViewModel: Observable {
    var layer: Layer { get }
    
    func drag(_ point: CGPoint)
    func endDragging(_ point: CGPoint)
}


struct CanvasView: View {
    
    @State var studio = Studio(tool: .pencil, color: .red)
    
    var body: some View {
        Canvas { context, size in
            for stroke in studio.layer.strokes {
                context.draw(stroke)
            }
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    studio.drag(value.location)
                }
                .onEnded { value in
                    studio.endDragging(value.location)
                }
        )
        .background {
            Image.Assets.canvas
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .cornerRadius(20)
    }
}


extension GraphicsContext {
    
    func draw(_ stroke: Stroke) {
        self.stroke(stroke.path, with: .color(stroke.color), lineWidth: 4)
    }
}
