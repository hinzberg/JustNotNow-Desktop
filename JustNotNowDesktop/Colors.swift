import SwiftUI

struct Colors {
    
    static let primaryAccent: Color = fromRGB(r: 102, g: 103, b: 171)
    
    // Background color for sections/cards throughout the app
    static let sectionBackground: Color = fromRGB(r: 102, g: 103, b: 171, a: 0.2)
    
    // Create a Color from 0-255 integer RGB values with optional alpha (0-1)
    static func fromRGB(r: Int, g: Int, b: Int, a: Double = 1.0) -> Color {
        let red = Double(max(0, min(255, r))) / 255.0
        let green = Double(max(0, min(255, g))) / 255.0
        let blue = Double(max(0, min(255, b))) / 255.0
        let alpha = max(0.0, min(1.0, a))
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}
