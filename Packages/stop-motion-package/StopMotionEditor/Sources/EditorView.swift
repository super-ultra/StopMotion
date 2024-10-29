import SwiftUI

import StopMotionToolbox

public struct EditorView: View {
    
    
    // MARK: - Public
    
    public init() {
    }
    
    // MARK: - View
    
    public var body: some View {
        VStack {
            ControlView(model: controlModel)
            
            Spacer().frame(height: 16)

            CanvasView()
            
            Spacer()
                .frame(height: 22)
            
            ToolView(model: toolModel)
        }
        .padding(.top, 20)
        .padding([.leading, .trailing], 16)
        .safeAreaBottomPadding()
    }
    
    // MARK: - Private
    
    private enum Guides {
        static let padding: CGFloat = 16
    }
    
    @State
    private var controlModel = ControlViewModelImpl()
    
    @State
    private var toolModel = ToolViewModelImpl()
    
}


#Preview {
    EditorView()
}
