import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var contentManager: ContentManager
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        List {
            Section {
                ForEach(contentManager.getKitchenTopics(), id: \.self) { topic in
                    NavigationLink(destination: KitchenLessonsView(topic: topic)) {
                        Label {
                            Text(topic.capitalized)
                                .font(Theme.bodyFont)
                        } icon: {
                            Image(systemName: "fork.knife")
                                .foregroundColor(Theme.accent)
                        }
                    }
                }
            } header: {
                Text("Kitchen Conversations")
                    .font(Theme.headlineFont)
            }
            
            Section {
                ForEach(contentManager.getHistoricalTopics(), id: \.self) { topic in
                    NavigationLink(destination: HistoricalLessonsView(topic: topic)) {
                        Label {
                            Text(topic.capitalized)
                                .font(Theme.bodyFont)
                        } icon: {
                            Image(systemName: "book.closed")
                                .foregroundColor(Theme.accent)
                        }
                    }
                }
            } header: {
                Text("Historical Conversations")
                    .font(Theme.headlineFont)
            }
            
            Section {
                ForEach(contentManager.getCulturalTopics(), id: \.self) { topic in
                    NavigationLink(destination: CulturalLessonsView(topic: topic)) {
                        Label {
                            Text(topic.capitalized)
                                .font(Theme.bodyFont)
                        } icon: {
                            Image(systemName: "building.columns")
                                .foregroundColor(Theme.accent)
                        }
                    }
                }
            } header: {
                Text("Cultural Lessons")
                    .font(Theme.headlineFont)
            }
        }
        .navigationTitle("Conversazione con la Nonna")
        .listStyle(.insetGrouped)
        .background(Theme.backgroundColor)
        .scrollContentBackground(.hidden)
        .alert("Error", isPresented: .constant(contentManager.error != nil)) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(contentManager.error?.localizedDescription ?? "Unknown error")
        }
        .overlay {
            if contentManager.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(Theme.accent)
            }
        }
    }
}