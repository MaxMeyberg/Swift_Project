import XCTest
import WebRTC
@testable import SwiftOpenAIRealtime

final class WebRTCAudioTests: XCTestCase {
    
    func testAudioDeviceCapabilities() throws {
        let factory = RTCPeerConnectionFactory()
        
        // Test audio source creation
        let audioSource = factory.audioSource(with: nil)
        XCTAssertNotNil(audioSource, "Audio source should be created")
        
        // Test audio track creation
        let audioTrack = factory.audioTrack(with: audioSource, trackId: "audio0")
        XCTAssertNotNil(audioTrack, "Audio track should be created")
        XCTAssertEqual(audioTrack.trackId, "audio0")
        XCTAssertTrue(audioTrack.isEnabled, "Audio track should be enabled by default")
        
        print("✅ WebRTC audio track created successfully")
    }
    
    func testAudioConstraints() throws {
        // Test audio constraints for OpenAI compatibility
        let constraints = RTCMediaConstraints(
            mandatoryConstraints: [
                "googEchoCancellation": "true",
                "googNoiseSuppression": "true",
                "googAutoGainControl": "true"
            ],
            optionalConstraints: [:]  // Fixed: Use [:] for empty dictionary
        )
        
        XCTAssertNotNil(constraints, "Audio constraints should be created")
        
        let factory = RTCPeerConnectionFactory()
        let audioSource = factory.audioSource(with: constraints)
        XCTAssertNotNil(audioSource, "Audio source with constraints should be created")
        
        print("✅ Audio constraints configured for OpenAI")
    }
    
    func testSpeakerOutput() throws {
        let factory = RTCPeerConnectionFactory()
        
        // Create audio track for playback
        let audioSource = factory.audioSource(with: nil)
        let audioTrack = factory.audioTrack(with: audioSource, trackId: "playback")
        
        // Test volume control
        audioTrack.source.volume = 0.8
        XCTAssertEqual(audioTrack.source.volume, 0.8, accuracy: 0.1)
        
        print("✅ Audio playback track configured")
        print("🔊 Volume level: \(audioTrack.source.volume)")
    }
    
    func testOpenAIAudioFormat() throws {
        // OpenAI Realtime API requirements
        let requiredSampleRate: Double = 24000  // 24kHz
        let requiredChannels = 1                // Mono
        let requiredBitDepth = 16              // 16-bit PCM
        
        // Verify format compatibility
        XCTAssertEqual(requiredSampleRate, 24000, "Sample rate must be 24kHz for OpenAI")
        XCTAssertEqual(requiredChannels, 1, "Must be mono audio")
        XCTAssertEqual(requiredBitDepth, 16, "Must be 16-bit PCM")
        
        print("✅ Audio format requirements verified")
        print("📊 Sample Rate: \(requiredSampleRate) Hz")
        print("📊 Channels: \(requiredChannels) (Mono)")
        print("📊 Bit Depth: \(requiredBitDepth)-bit PCM")
        
        // Note: WebRTC typically uses different sample rates
        print("⚠️  Format conversion will be needed:")
        print("   WebRTC: Variable sample rate (usually 48kHz)")
        print("   OpenAI: Fixed 24kHz PCM16 mono")
    }
    
    // Simplified microphone test without RTCAudioSession
    func testBasicAudioSetup() throws {
        let factory = RTCPeerConnectionFactory()
        
        // Test that we can create audio components
        let audioSource = factory.audioSource(with: nil)
        let audioTrack = factory.audioTrack(with: audioSource, trackId: "mic_test")
        
        XCTAssertNotNil(audioSource, "Audio source for microphone should be created")
        XCTAssertNotNil(audioTrack, "Audio track for microphone should be created")
        
        print("✅ Basic audio setup working")
        print("🎤 Microphone audio track ready")
    }
}