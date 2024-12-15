import Foundation

struct NonnaResponse: Codable, Hashable {
    let reaction: String?
    let response: String
    let gesture: String?
    let culturalNote: String?
    let followUps: [String]?
    let memory: String?
    let passionateDetails: [String: PassionateDetail]?
    let rules: [String]?
    let culturalNotes: CulturalNotes?
    let voiceChanges: String?
    let branching: [String: Branching]?
    
    enum CodingKeys: String, CodingKey {
        case reaction
        case response
        case gesture
        case culturalNote = "cultural_note"
        case followUps = "follow_ups"
        case memory
        case passionateDetails = "passionate_details"
        case rules
        case culturalNotes = "cultural_notes"
        case voiceChanges = "voice_changes"
        case branching
    }
}

struct PassionateDetail: Codable, Hashable {
    let explanation: String?
    let culturalImpact: String?
    let followUps: [String]?
    let emojiLogicExplanation: EmojiLogic?
    let emojiLogicCulturalImpact: EmojiLogic?
    let emojiLogicFollowUps: [String: EmojiLogic]?
    
    enum CodingKeys: String, CodingKey {
        case explanation
        case culturalImpact = "cultural_impact"
        case followUps = "follow_ups"
        case emojiLogicExplanation = "emoji_logic_explanation"
        case emojiLogicCulturalImpact = "emoji_logic_cultural_impact"
        case emojiLogicFollowUps = "emoji_logic_follow_ups"
    }
}

struct CulturalNotes: Codable, Hashable {
    let standing: String?
    let timing: String?
    let variations: [String: String]?
    let emojiLogicStanding: EmojiLogic?
    let emojiLogicTiming: EmojiLogic?
    
    enum CodingKeys: String, CodingKey {
        case standing
        case timing
        case variations
        case emojiLogicStanding = "emoji_logic_standing"
        case emojiLogicTiming = "emoji_logic_timing"
    }
}