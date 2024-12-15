import SwiftUI

struct ConversationCardView: View {
    let question: String
    let emojis: [String]
    let response: NonnaResponse?
    
    @StateObject private var audioService = AudioService()
    @State private var showingResponse = false
    @State private var showingFollowUps = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.spacing) {
            // Question Section
            questionSection
            
            // Response Section
            if showingResponse {
                responseSection
            }
            
            // Follow-ups Section
            if showingResponse, showingFollowUps, let followUps = response?.followUps, !followUps.isEmpty {
                followUpsSection(followUps)
            }
            
            // Controls
            controlsSection
        }
        .cardStyle()
        .animation(Theme.defaultAnimation, value: showingResponse)
        .animation(Theme.defaultAnimation, value: showingFollowUps)
    }
    
    private var questionSection: some View {
        VStack(alignment: .leading, spacing: Theme.spacing) {
            Text(question)
                .font(Theme.headlineFont)
                .foregroundColor(.white)
            
            HStack(spacing: 4) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .font(.title2)
                }
            }
            
            playButton(for: question)
        }
    }
    
    @ViewBuilder
    private var responseSection: some View {
        if let response = response {
            VStack(alignment: .leading, spacing: Theme.spacing) {
                if let reaction = response.reaction {
                    Text(reaction)
                        .italic()
                        .foregroundColor(.secondary)
                }
                
                Text(response.response)
                    .font(Theme.bodyFont)
                    .foregroundColor(.white)
                
                playButton(for: response.response)
                
                if let gesture = response.gesture {
                    Text(gesture)
                        .italic()
                        .foregroundColor(.secondary)
                }
                
                if let note = response.culturalNote {
                    Text(note)
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
            }
        }
    }
    
    private func followUpsSection(_ followUps: [String]) -> some View {
        VStack(alignment: .leading, spacing: Theme.spacing) {
            Text("Follow-up Questions")
                .font(Theme.headlineFont)
                .foregroundColor(.white)
            
            ForEach(followUps, id: \.self) { question in
                HStack {
                    Text(question)
                        .font(Theme.bodyFont)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button {
                        audioService.speak(question)
                    } label: {
                        Image(systemName: "play.circle.fill")
                            .foregroundColor(Theme.accent)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
    
    private var controlsSection: some View {
        HStack(spacing: Theme.spacing) {
            Button {
                withAnimation {
                    showingResponse.toggle()
                    if !showingResponse {
                        showingFollowUps = false
                    }
                }
            } label: {
                Text(showingResponse ? "Hide Response" : "Show Response")
                    .frame(maxWidth: .infinity)
            }
            .primaryButtonStyle()
            
            if showingResponse, let response = response, response.followUps?.isEmpty == false {
                Button {
                    withAnimation {
                        showingFollowUps.toggle()
                    }
                } label: {
                    Image(systemName: showingFollowUps ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                        .font(.title2)
                        .foregroundColor(Theme.accent)
                }
            }
        }
    }
    
    private func playButton(for text: String) -> some View {
        Button {
            if audioService.isPlaying {
                audioService.stop()
            } else {
                audioService.speak(text)
            }
        } label: {
            Label(audioService.isPlaying ? "Stop" : "Play", systemImage: audioService.isPlaying ? "stop.circle.fill" : "play.circle.fill")
                .font(Theme.buttonFont)
                .foregroundColor(Theme.accent)
        }
    }
}