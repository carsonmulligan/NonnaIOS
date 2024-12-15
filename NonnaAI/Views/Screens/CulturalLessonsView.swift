import SwiftUI

struct CulturalLessonsView: View {
    let topic: String
    
    @EnvironmentObject private var contentManager: ContentManager
    
    var body: some View {
        ScrollView {
            if let conversation = contentManager.content?.culturalLessons.topics[topic]?.opening {
                ConversationCardView(
                    question: conversation.user,
                    emojis: conversation.emojiLogic.emojis,
                    response: conversation.nonna
                )
            } else {
                Text("No conversation available")
                    .font(Theme.bodyFont)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle(topic.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .background(Theme.backgroundColor)
    }
}