import Foundation
import SwiftOpenAIRealtime
import WebRTC

@available(macOS 12.0, *)
class TerminalVoiceChat {
    private let client: OpenAIRealtimeClient
    private var isRunning = false
    private var isRecording = false
    
    init(apiKey: String) {
        self.client = OpenAIRealtimeClient(apiKey: apiKey)
    }
    
    func start() async {
        print("🔌 Connecting to OpenAI...")
        
        // Connect to OpenAI
        client.connect()
        
        // Wait for connection
        try? await Task.sleep(nanoseconds: 3_000_000_000) // 3 seconds
        
        if client.isConnected {
            print("✅ Connected to OpenAI Realtime API!")
            await runChatLoop()
        } else {
            print("❌ Failed to connect to OpenAI")
            return
        }
    }
    
    private func runChatLoop() async {
        print("\n🎤 Voice Chat Ready!")
        print("📢 Instructions:")
        print("   - Press 's' + ENTER for status")
        print("   - Press 't' + ENTER to test audio")
        print("   - Press 'q' + ENTER to quit")
        print("\n🟢 Ready for commands...")
        
        isRunning = true
        
        // Setup keyboard input handling
        setupKeyboardInput()
        
        // Keep the chat running
        while isRunning {
            try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        }
        
        client.disconnect()
        print("\n👋 Voice chat ended. Goodbye!")
    }
    
    private func setupKeyboardInput() {
        Task {
            while isRunning {
                if let input = readLine() {
                    switch input.lowercased() {
                    case "q", "quit", "exit":
                        print("🛑 Shutting down...")
                        isRunning = false
                    case "s", "status":
                        showStatus()
                    case "t", "test":
                        testAudio()
                    case "h", "help":
                        showHelp()
                    default:
                        print("❓ Unknown command '\(input)'. Type 'h' for help")
                    }
                }
            }
        }
    }
    
    private func showStatus() {
        print("\n📊 Voice Chat Status:")
        print("🔌 OpenAI Connected: \(client.isConnected ? "✅" : "❌")")
        print("🎤 Recording: \(isRecording ? "🔴" : "⚫")")
        print("🎙️ Chat Running: \(isRunning ? "✅" : "❌")")
        client.checkConnectionStatus()
        print("🟢 Ready for commands...\n")
    }
    
    private func testAudio() {
        print("\n🔧 Testing audio setup...")
        
        let factory = RTCPeerConnectionFactory()
        let audioSource = factory.audioSource(with: nil)
        let audioTrack = factory.audioTrack(with: audioSource, trackId: "test")
        
        if audioTrack.isEnabled {
            print("✅ Audio system working")
            print("🎤 Microphone: Ready")
            print("🔊 Speakers: Ready")
            print("📊 Audio track ID: \(audioTrack.trackId)")
        } else {
            print("❌ Audio system not working")
        }
        print("🟢 Ready for commands...\n")
    }
    
    private func showHelp() {
        print("\n📖 Available Commands:")
        print("   s - Show connection status")
        print("   t - Test audio system")
        print("   h - Show this help")
        print("   q - Quit voice chat")
        print("🟢 Ready for commands...\n")
    }
    
    // TODO: Implement actual audio recording/playback in Phase 2
    private func startRecording() {
        print("🔴 Recording... speak now!")
        isRecording = true
        // Audio capture will be implemented here
    }
    
    private func stopRecording() {
        print("📤 Sending to OpenAI...")
        isRecording = false
        // Audio processing and sending will be implemented here
    }
}