# Swift OpenAI Realtime API Client

A Swift Package Manager library for real-time voice conversations with OpenAI's GPT models. Talk to ChatGPT naturally using your voice - like Siri, but powered by OpenAI's advanced language models.

## 🎯 Features

- ✅ **Real-time Voice Chat** - Direct audio conversations with OpenAI's GPT models
- ✅ **WebRTC Integration** - High-quality audio capture and playback
- ✅ **Secure API Management** - Bitwarden integration for safe API key storage
- ✅ **Swift Package Manager** - Easy integration into iOS/macOS projects
- 🚧 **Audio Streaming Pipeline** - Bidirectional audio streaming (in development)
- 🚧 **Session Configuration** - Customizable AI personality and voice settings

## 🚀 Quick Start

### Requirements

- macOS 12.0+
- Swift 5.7+
- OpenAI API key with Realtime API access
- Bitwarden CLI (for secure API key management)

### Installation

Add this package to your Swift project:

```swift
dependencies: [
    .package(url: "https://github.com/MaxMeyberg/Swift_Project.git", from: "1.0.0")
]
```

### Basic Usage

```swift
import SwiftOpenAIRealtime

// Initialize the client
let client = OpenAIRealtimeClient(apiKey: "your-openai-api-key")

// Connect to OpenAI
client.connect()

// Connection status will be logged automatically
// Look for: "✅ Connected to OpenAI Realtime API!"
```

### Secure API Key Setup

We recommend using Bitwarden for secure API key management:

```bash
# Install Bitwarden CLI
brew install bitwarden-cli

# Store your OpenAI API key
bw create item '{"type":1,"name":"Open AI API Key","login":{"password":"your-sk-key-here"}}'

# Use in your app
export OPENAI_API_KEY="$(bw get password 'Open AI API Key')"
```

## 🏗️ Architecture

```
Your Voice → WebRTC → OpenAI Realtime API → AI Response → Your Speakers
```

### Core Components

- **WebRTC Module**: Handles audio capture from microphone and playbook to speakers
- **OpenAI Client**: Manages WebSocket connection to OpenAI's Realtime API
- **Security Layer**: Secure API key management with Bitwarden integration

## 📋 Current Status

### ✅ Working Features
- [x] WebRTC audio framework integration
- [x] OpenAI Realtime API connection
- [x] WebSocket session management
- [x] Secure API key handling
- [x] Connection status monitoring
- [x] Comprehensive test suite

### 🚧 In Development
- [ ] Audio format conversion (WebRTC ↔ PCM16)
- [ ] Bidirectional audio streaming
- [ ] Session configuration options
- [ ] Voice chat interface

## 🧪 Testing

The package includes comprehensive tests for both WebRTC and OpenAI integration:

```bash
# Run all tests
swift test

# Test WebRTC integration
swift test --filter WebRTCTests

# Test OpenAI connection (requires API key)
export OPENAI_API_KEY="your-key-here"
swift test --filter OpenAIRealtimeTests
```

### Test Results
```
✅ WebRTC Factory Creation: PASSED
✅ WebRTC Peer Connection: PASSED  
✅ OpenAI API Key Format: PASSED
✅ OpenAI WebSocket Connection: PASSED
✅ OpenAI Session Creation: PASSED
```

## 🔧 Technical Specifications

### Audio Format
- **Sample Rate**: 24,000 Hz
- **Bit Depth**: 16-bit PCM
- **Channels**: Mono
- **Format**: Linear PCM, little-endian

### OpenAI Configuration
- **Model**: `gpt-4o-realtime-preview-2024-10-01`
- **Voice**: `alloy` (configurable)
- **Modalities**: Audio + Text
- **Protocol**: WebSocket over WSS

## 🔒 Security

### API Key Protection
- ✅ Bitwarden integration for secure storage
- ✅ `.gitignore` prevents accidental commits
- ✅ GitHub push protection enabled
- ✅ Environment variable isolation

### Network Security
- ✅ WSS (encrypted WebSocket) connections
- ✅ Bearer token authentication
- ✅ Secure header handling

## 📖 Documentation

### Connection Example
```swift
let client = OpenAIRealtimeClient(apiKey: apiKey)

// Connect with status monitoring
client.connect()

// Check connection status
client.checkConnectionStatus()
// Output:
// 📊 WebSocket State: running
// 📊 Is Connected: true

// Disconnect when done
client.disconnect()
```

### Session Information
When connected, OpenAI provides session details:
```json
{
  "type": "session.created",
  "session": {
    "id": "sess_...",
    "voice": "alloy",
    "input_audio_format": "pcm16",
    "output_audio_format": "pcm16",
    "modalities": ["audio", "text"]
  }
}
```

## 🚧 Development Roadmap

### Phase 1: Foundation ✅
- [x] Swift Package setup
- [x] WebRTC integration
- [x] OpenAI API connection
- [x] Security implementation

### Phase 2: Audio Pipeline 🚧
- [ ] Audio format conversion
- [ ] Real-time audio streaming
- [ ] Audio buffering and synchronization

### Phase 3: User Experience
- [ ] Voice chat interface
- [ ] Session configuration
- [ ] Error handling and recovery
- [ ] Conversation history

### Phase 4: Advanced Features
- [ ] iOS compatibility
- [ ] Multiple voice options
- [ ] Custom instructions
- [ ] Multi-modal support

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Setup
```bash
# Clone the repository
git clone https://github.com/MaxMeyberg/Swift_Project.git
cd Swift_Project

# Install dependencies
swift package resolve

# Run tests
swift test
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **OpenAI** for the Realtime API
- **Google** for the WebRTC framework
- **Swift Community** for excellent package management tools

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/MaxMeyberg/Swift_Project/issues)
- **Discussions**: [GitHub Discussions](https://github.com/MaxMeyberg/Swift_Project/discussions)
- **Documentation**: [Wiki](https://github.com/MaxMeyberg/Swift_Project/wiki)

---

**Status**: Foundation Complete ✅ | **Next**: Audio Pipeline Integration 🚧

Made with ❤️ for the Swift and AI community