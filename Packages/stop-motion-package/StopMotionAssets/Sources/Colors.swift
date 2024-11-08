import SwiftUI
import UIKit


extension UIColor {
    
    public enum Assets {
        public static let solidBlack = UIColor(named: "solid-black", in: .module, compatibleWith: nil)!
        public static let solidGrey = UIColor(named: "solid-grey", in: .module, compatibleWith: nil)!
        public static let solidWhite = UIColor(named: "solid-white", in: .module, compatibleWith: nil)!
        public static let solidBlue = UIColor(named: "solid-blue", in: .module, compatibleWith: nil)!
        public static let solidRed = UIColor(named: "solid-red", in: .module, compatibleWith: nil)!
        public static let tintAccent = UIColor(named: "tint-accent-green", in: .module, compatibleWith: nil)!
        public static let tintAccentRed = UIColor(named: "tint-accent-red", in: .module, compatibleWith: nil)!
        public static let tintPrimary = UIColor(named: "tint-primary", in: .module, compatibleWith: nil)!
    }
    
}


extension Color {
    
    public enum Assets {
        public static let solidBlack = Color("solid-black", bundle: .module)
        public static let solidGrey = Color("solid-grey", bundle: .module)
        public static let solidWhite = Color("solid-white", bundle: .module)
        public static let solidBlue = Color("solid-blue", bundle: .module)
        public static let solidRed = Color("solid-red", bundle: .module)
        public static let tintAccent = Color("tint-accent-green", bundle: .module)
        public static let tintAccentRed = Color("tint-accent-red", bundle: .module)
        public static let tintPrimary = Color("tint-primary", bundle: .module)
    }
    
}
