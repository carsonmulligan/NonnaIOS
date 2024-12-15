import AVFoundation
import Combine

@MainActor
class AudioService: NSObject, ObservableObject {
    @Published private(set) var isPlaying = false
    @Published private(set) var error: Error?
    
    private let synthesizer = AVSpeechSynthesizer()
    private var currentUtterance: AVSpeechUtterance?
    
    override init() {
        super.init()
        synthesizer.delegate = self
        
        // Request authorization for speech synthesis
        AVSpeechSynthesisVoice.speechVoices()
    }
    
    func speak(_ text: String) {
        stop()
        
        let utterance = AVSpeechUtterance(string: text)
        
        // Try to get an Italian voice
        if let italianVoice = AVSpeechSynthesisVoice.speechVoices().first(where: { $0.language.starts(with: "it-") }) {
            utterance.voice = italianVoice
        } else {
            utterance.voice = AVSpeechSynthesisVoice(language: "it-IT")
        }
        
        // Configure speech parameters
        utterance.rate = 0.5 // Slower rate for better comprehension
        utterance.pitchMultiplier = 1.1 // Slightly higher pitch for clarity
        utterance.volume = 1.0
        
        currentUtterance = utterance
        synthesizer.speak(utterance)
        isPlaying = true
    }
    
    func stop() {
        if isPlaying {
            synthesizer.stopSpeaking(at: .immediate)
            isPlaying = false
        }
    }
    
    enum AudioError: LocalizedError {
        case noItalianVoice
        case speakingFailed
        
        var errorDescription: String? {
            switch self {
            case .noItalianVoice:
                return "Could not find Italian voice for speech synthesis"
            case .speakingFailed:
                return "Failed to speak the text"
            }
        }
    }
}

extension AudioService: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        if utterance === currentUtterance {
            isPlaying = false
            currentUtterance = nil
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        if utterance === currentUtterance {
            isPlaying = false
            currentUtterance = nil
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        if utterance === currentUtterance {
            isPlaying = false
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        if utterance === currentUtterance {
            isPlaying = true
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        if utterance === currentUtterance {
            isPlaying = true
        }
    }
}