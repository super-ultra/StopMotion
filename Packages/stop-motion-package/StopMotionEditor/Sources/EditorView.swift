import SwiftUI

public struct EditorView: View {
    
    
    // MARK: - Public
    
    public init() {
    }
    
    // MARK: - View
    
    public var body: some View {
        VStack {
            Spacer()
            ToolView(model: model)
        }
    }
    
    // MARK: - Private
    
    @State
    var model = ToolViewModelImpl()
}
