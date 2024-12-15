import Foundation
import Combine

class ContentManager: ObservableObject {
    @Published var content: ConversationContent?
    @Published var error: Error?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadContent()
    }
    
    func loadContent() {
        isLoading = true
        
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            error = ContentError.fileNotFound
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ConversationContent.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] content in
                self?.content = content
            }
            .store(in: &cancellables)
    }
    
    enum ContentError: LocalizedError {
        case fileNotFound
        
        var errorDescription: String? {
            switch self {
            case .fileNotFound:
                return "Could not find questions.json in the app bundle"
            }
        }
    }
    
    // Helper methods for accessing content
    func getKitchenTopics() -> [String] {
        Array(content?.kitchenConversations.topics.keys ?? []).sorted()
    }
    
    func getHistoricalTopics() -> [String] {
        Array(content?.historicalConversations.topics.keys ?? []).sorted()
    }
    
    func getCulturalTopics() -> [String] {
        Array(content?.culturalLessons.topics.keys ?? []).sorted()
    }
}