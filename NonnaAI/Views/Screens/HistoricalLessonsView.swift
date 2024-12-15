import SwiftUI

struct HistoricalLessonsView: View {
    let topic: String
    
    @EnvironmentObject private var contentManager: ContentManager
    
    var body: some View {
        ScrollView {
            if let conversation = contentManager.content?.historicalConversations.topics[topic]?.opening {
                ConversationCardView(
                    question: conversation.user,
                    emojis: conversation.emojiLogic.emojis,
                    response: conversation.nonno ?? conversation.nonna
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