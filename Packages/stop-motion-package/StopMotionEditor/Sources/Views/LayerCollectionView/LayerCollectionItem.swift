//
//  File.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 01.11.2024.
//

import SwiftUI
import StopMotionDrawing
import StopMotionAssets

struct LayerCollectionItemModel {
    let layer: Layer
    let index: String
    let isSelected: Bool
    let originalCanvasSize: CGSize
}


struct LayerCollectionItem: View {
    
    let model: LayerCollectionItemModel
    
    var body: some View {
        Canvas { context, size in
            context.scaleBy(
                x: size.width / model.originalCanvasSize.width,
                y: size.height / model.originalCanvasSize.height
            )
            
            context.draw(model.layer)
        }
        .background {
            Image.Assets.canvas
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .overlay {
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Text(model.index)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.Assets.tintPrimary)
                        .padding(4)
                        .background(.regularMaterial)
                        .cornerRadius(4)
                        .padding(8)
                }
            }
        }
        .cornerRadius(Static.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Static.cornerRadius)
                .stroke(model.isSelected ? Color.Assets.tintAccent : .clear, lineWidth: 2)
        )
    }
    
    // MARK: - Private
    
    private enum Static {
        static let cornerRadius: CGFloat = 16
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    VStack(spacing: 10) {
        LayerCollectionItem(model: LayerCollectionItemModel(
            layer: Layer(
                strokes: [
                    Stroke(
                        path: Path(ellipseIn: CGRect(origin: .zero, size: CGSize(width: 200, height: 120))),
                        color: UIColor.red.cgColor,
                        tool: .default(.brush)
                    )
                ]
            ),
            index: "1",
            isSelected: false,
            originalCanvasSize: CGSize(width: 400, height: 750)
        ))
        .frame(width: 100, height: 150)
        
        LayerCollectionItem(model: LayerCollectionItemModel(
            layer: Layer(
                strokes: [
                    Stroke(
                        path: Path(ellipseIn: CGRect(origin: .zero, size: CGSize(width: 200, height: 120))),
                        color: UIColor.red.cgColor,
                        tool: .default(.brush)
                    )
                ]
            ),
            index: "900",
            isSelected: true,
            originalCanvasSize: CGSize(width: 400, height: 750)
        ))
        .frame(width: 100, height: 150)
    }
}
