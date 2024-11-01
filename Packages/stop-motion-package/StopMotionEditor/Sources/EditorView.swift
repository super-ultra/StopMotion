import SwiftUI

import StopMotionToolbox

public struct EditorView: View {
    
    
    // MARK: - Public
    
    public init() {
    }
    
    // MARK: - View
    
    public var body: some View {
        VStack {
            ControlView(model: model.controlModel)
            
            Spacer().frame(height: 16)

            CanvasView(model: model.canvasModel, isAnimating: model.controlModel.isPlaying)
            
            Spacer()
                .frame(height: 22)
            
            ToolView(model: model.toolModel)
                .opacity(model.controlModel.isPlaying ? 0.0 : 1.0)
        }
        .padding(.top, 20)
        .padding([.leading, .trailing], 16)
        .overlay {
            if !model.controlModel.isPlaying {
                overlayView()
            }
        }
        .safeAreaBottomPadding()
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .sheet(item: $model.router.destination) { destination in
            model.router.view(for: destination)
        }
    }
    
    // MARK: - Private
    
    private enum Guides {
        static let padding: CGFloat = 16
    }
    
    @State
    private var model = EditorViewModelImpl()
    
    @ViewBuilder
    private func overlayView() -> some View {
        if model.toolModel.mode == .colorPicking {
            VStack {
                Spacer()
                SmallColorPicker { color in
                    model.toolModel.selectColor(color)
                }
                .padding(.bottom, 48)
            }
        }
    }
    
}


#Preview {
    EditorView()
}
