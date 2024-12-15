import SwiftUI

enum Theme {
    // Colors from style guidelines
    static let backgroundColor = Color(hex: "1E2B25") // Deep Forest Green
    static let cardBackground = Color(hex: "2A3830") // Lighter Green
    static let accent = Color(hex: "C4A484") // Warm Beige
    static let error = Color(hex: "FF6B6B") // Soft Red
    static let success = Color(hex: "4ECB71") // Muted Green
    
    // Typography
    static let titleFont = Font.system(.title, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded).weight(.semibold)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let buttonFont = Font.system(.body, design: .rounded).weight(.semibold)
    
    // Spacing
    static let spacing: CGFloat = 16
    static let cornerRadius: CGFloat = 12
    static let padding: CGFloat = 16
    
    // Animation
    static let defaultAnimation: Animation = .easeInOut(duration: 0.3)
}

// Color extension for hex initialization
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// View modifiers for consistent styling
extension View {
    func cardStyle() -> some View {
        self
            .padding(Theme.padding)
            .background(Theme.cardBackground)
            .cornerRadius(Theme.cornerRadius)
    }
    
    func primaryButtonStyle() -> some View {
        self
            .padding()
            .background(Theme.accent)
            .foregroundColor(.white)
            .cornerRadius(Theme.cornerRadius)
            .font(Theme.buttonFont)
    }
}