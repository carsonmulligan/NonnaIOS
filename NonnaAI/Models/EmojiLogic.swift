import Foundation

struct EmojiLogic: Codable, Hashable {
    let emojis: [String]
    let text: [String]
    
    var combinedEmojis: String {
        emojis.joined(separator: " ")
    }
    
    var description: String {
        text.joined(separator: ", ")
    }
}