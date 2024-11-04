//
//  LayerCollectionView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 01.11.2024.
//

import SwiftUI

struct LayerCollectionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let model: LayerCollectionViewModel
    
    var body: some View {
        ScrollView {
            let columns = [GridItem](repeating: GridItem(.flexible(), spacing: Static.spacing), count: LayerCollectionGuides.columns)
            
            LazyVGrid(columns: columns, spacing: Static.spacing) {
                ForEach(0..<model.itemsCount, id: \.self) { index in
                    Button(
                        action: {
                            model.selectItem(at: index)
                            presentationMode.wrappedValue.dismiss()
                        }
                    ) {
                        LayerCollectionItem(model: model.item(at: index))
                            .aspectRatio(model.itemAspectRatio, contentMode: .fill)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(Strings.LayersCollectionView.allLayers)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(Strings.Common.close) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    // MARK: - Private
    
    private enum Static {
        static let spacing: CGFloat = 16
    }
}
