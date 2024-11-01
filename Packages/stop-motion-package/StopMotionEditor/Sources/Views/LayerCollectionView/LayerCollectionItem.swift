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
}


struct LayerCollectionItem: View {
    
    let model: LayerCollectionItemModel
    
    var body: some View {
        Canvas { context, size in
            context.scaleBy(
                x: 1.0 / CGFloat(LayerCollectionGuides.columns),
                y: 1.0 / CGFloat(LayerCollectionGuides.columns)
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
                        .bold()
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
                        color: .red,
                        tool: .pencil
                    )
                ]
            ),
            index: "1",
            isSelected: false)
        )
        .frame(width: 100, height: 150)
        
        LayerCollectionItem(model: LayerCollectionItemModel(
            layer: Layer(
                strokes: [
                    Stroke(
                        path: Path(ellipseIn: CGRect(origin: .zero, size: CGSize(width: 200, height: 120))),
                        color: .red,
                        tool: .pencil
                    )
                ]
            ),
            index: "900",
            isSelected: true)
        )
        .frame(width: 100, height: 150)
    }
}
