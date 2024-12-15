# front_end_agent.md

## Opinionated, Concise Approach
Use SwiftUI. Keep UI minimal: a main view that loads `questions.json` and shows the conversation card. Emphasize fast iteration:
- **No Complex Navigation**: Just a simple state machine: Question → Response → Follow-up.
- **Audio Playback**: Use AVSpeechSynthesizer directly. No extra layers.
- **Design**: Minimal styling, a few colors and emojis. No complex animations or custom fonts initially. Focus on readability and speed.
- **Testing**: Just ensure screens load and TTS works. No fancy UI tests yet.
 