import Foundation
import SwiftOpenAIRealtime

// Simple main function without @main attribute
@available(macOS 12.0, *)
func runVoiceChat() async {
    print("🎙️ Swift OpenAI Voice Chat v1.0")
    print(String(repeating: "=", count: 40))
    
    // Check for API key
    guard let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"], !apiKey.isEmpty else {
        print("❌ Error: OPENAI_API_KEY environment variable not set")
        print("💡 Run: export OPENAI_API_KEY=\"$(bw get password 'Open AI API Key')\"")
        return
    }
    
    // Initialize the voice chat
    let voiceChat = TerminalVoiceChat(apiKey: apiKey)
    await voiceChat.start()
}

// Entry point
if #available(macOS 12.0, *) {
    Task {
        await runVoiceChat()
        exit(0)
    }
    RunLoop.main.run()
} else {
    print("❌ This app requires macOS 12.0 or later")
    exit(1)
}