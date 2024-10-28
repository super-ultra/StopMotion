import SwiftUI

extension Image {
    
    public enum Assets {
        public static let controlLayers = Image("control-layers", bundle: .module)
        public static let controlPause = Image("control-pause", bundle: .module)
        public static let controlBin = Image("control-bin", bundle: .module)
        public static let controlNewLayer = Image("control-new-layer", bundle: .module)
        public static let controlPlay = Image("control-play", bundle: .module)
        public static let controlUndo = Image("control-undo", bundle: .module)
        public static let controlRedo = Image("control-redo", bundle: .module)
    
        public static let figureCircle = Image("figure-circle", bundle: .module)
        public static let figureTriangle = Image("figure-triangle", bundle: .module)
        public static let figureArrowUp = Image("figure-arrow-up", bundle: .module)
        public static let figureSquare = Image("figure-square", bundle: .module)
        
        public static let toolErase = Image("tool-erase", bundle: .module)
        public static let toolPalette = Image("tool-palette", bundle: .module)
        public static let toolBrush = Image("tool-brush", bundle: .module)
        public static let toolFigure = Image("tool-figure", bundle: .module)
        public static let toolPencil = Image("tool-pencil", bundle: .module)
        
        public static let canvas = Image("canvas", bundle: .module)
    }
    
}
