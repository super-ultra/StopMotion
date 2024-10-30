//
//  CanvasView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 28.10.2024.
//

import SwiftUI

import StopMotionAssets
import StopMotionDrawing



struct CanvasView: View {
    
    @State
    var model: CanvasViewModel
    
    var body: some View {
        Canvas { context, size in
            for stroke in model.layer.strokes {
                context.draw(stroke)
            }
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    model.drag(value.location)
                }
                .onEnded { value in
                    model.endDragging(value.location)
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
    
    fileprivate func draw(_ stroke: Stroke) {
        let shading: GraphicsContext.Shading = switch stroke.tool {
        case .eraser:
            .color(.white)
        case .pencil:
            .color(stroke.color)
        }
        
        self.stroke(stroke.path, with: shading, lineWidth: 4)
    }
    
}
