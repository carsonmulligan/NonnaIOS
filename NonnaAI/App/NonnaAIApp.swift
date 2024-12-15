import SwiftUI

@main
struct NonnaAIApp: App {
    @StateObject private var contentManager = ContentManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeScreen()
            }
            .environmentObject(contentManager)
            .preferredColorScheme(.dark)
            .background(Theme.backgroundColor)
        }
    }
}
