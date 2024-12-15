import Foundation

struct ConversationContent: Codable {
    let kitchenConversations: ConversationCategory
    let historicalConversations: ConversationCategory
    let culturalLessons: ConversationCategory
    
    enum CodingKeys: String, CodingKey {
        case kitchenConversations = "kitchen_conversations"
        case historicalConversations = "historical_conversations"
        case culturalLessons = "cultural_lessons"
    }
}

struct ConversationCategory: Codable {
    let topics: [String: Topic]
    
    enum CodingKeys: String, CodingKey {
        case topics
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let topicsContainer = try? container.decode([String: Topic].self, forKey: .topics) {
            topics = topicsContainer
        } else {
            // If topics is not explicitly defined, treat the entire category as topics
            let container = try decoder.singleValueContainer()
            topics = try container.decode([String: Topic].self)
        }
    }
}

struct Topic: Codable {
    let opening: Opening
}

struct Opening: Codable {
    let user: String
    let emojiLogic: EmojiLogic
    let nonna: NonnaResponse?
    let nonno: NonnaResponse?
    
    enum CodingKeys: String, CodingKey {
        case user
        case emojiLogic = "emoji_logic"
        case nonna
        case nonno
    }
}

struct Branching: Codable {
    let questions: [String]?
    let emojiLogicQuestions: [String: EmojiLogicQuestion]?
    
    enum CodingKeys: String, CodingKey {
        case questions
        case emojiLogicQuestions = "emoji_logic_questions"
    }
}

struct EmojiLogicQuestion: Codable {
    let emojis: [String]
    let text: [String]
}