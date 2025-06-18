import Foundation

@available(macOS 12.0, *)  // Add this line
public class OpenAIRealtimeClient: NSObject {
    private var webSocketTask: URLSessionWebSocketTask?
    private let apiKey: String
    private let realtimeURL = "wss://api.openai.com/v1/realtime?model=gpt-4o-realtime-preview-2024-10-01"
    
    public private(set) var isConnected = false
    
    public init(apiKey: String) {
        self.apiKey = apiKey
        super.init()
    }

    public func checkConnectionStatus() {
        if let task = webSocketTask {
            print("📊 WebSocket State: \(task.state)")
            print("📊 WebSocket Close Code: \(task.closeCode)")
            print("📊 Is Connected: \(isConnected)")
        } else {
            print("📊 No WebSocket task exists")
        }
    }

    // ADD THIS METHOD TO CHECK CONNECTION STATUS:
    public func connect() {
        print("🔑 API Key: \(String(apiKey.prefix(10)))...")
        print("🌐 URL: \(realtimeURL)")
        
        var request = URLRequest(url: URL(string: realtimeURL)!)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("realtime=v1", forHTTPHeaderField: "OpenAI-Beta")
        
        // Add debug headers
        print("📋 Headers:")
        print("   Authorization: Bearer \(String(apiKey.prefix(20)))...")
        print("   OpenAI-Beta: realtime=v1")
        
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.delegate = self
        webSocketTask?.resume()
        
        print("🔌 Connecting to OpenAI Realtime API...")
        startListening()
    }
    


    private func startListening() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .success(let message):
                self?.handleMessage(message)
                self?.startListening() // Continue listening
            case .failure(let error):
                print("❌ WebSocket error: \(error)")
            }
        }
    }
    
    // ADD THIS NEW METHOD:
    private func handleMessage(_ message: URLSessionWebSocketTask.Message) {
        switch message {
        case .string(let text):
            print("📨 OpenAI Response: \(text)")
        case .data(let data):
            print("📦 OpenAI Data: \(data.count) bytes")
        @unknown default:
            print("❓ Unknown message type")
        }
    }
    
    public func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        print("❌ Disconnected from OpenAI")
    }
}


@available(macOS 12.0, *)  // Add this line
extension OpenAIRealtimeClient: URLSessionWebSocketDelegate {
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("✅ Connected to OpenAI Realtime API!")
        isConnected = true
    }
    
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("❌ WebSocket closed: \(closeCode)")
        isConnected = false
    }

    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("💥 WebSocket connection error: \(error)")
            print("💥 Error description: \(error.localizedDescription)")
        }
        isConnected = false
    }
        

    

}