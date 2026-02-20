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
    
    // Helper function to return a red→green gradient color based on priority (1..6)
    public static func priorityColor(for item: ToDoItem) -> Color {
        
        if item.isCompleted {
            return .secondary
        }
        
        // Only 1...6 are valid; everything else is gray
        guard (1...6).contains(item.priority) else {
            return .gray
        }
        
        let clamped = item.priority
        
        // Map 1 → red, 6 → green with a smooth gradient in between
        let t = Double(clamped - 1) / 5.0     // 0.0 ... 1.0
        let red   = 1.0 - t                   // 1 → 0
        let green = t                         // 0 → 1
        
        return Color(red: red, green: green, blue: 0.0)
    }
    
    
}
