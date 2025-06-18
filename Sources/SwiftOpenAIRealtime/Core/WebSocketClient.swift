import Foundation

public class WebSocketClient { 
    // My computer is the client
    // OPEN AI is the server

    // Connection State email
    public enum ConnectionState {
        case disconnected
        case connecting
        case connected
        case failed(Error)
    }

    public enum WebSocketError: Error { // Potential error cases
        case connectionFailed
        case invalidURL 
        case notConnected 
        case authFail 
    }


    private var webSocketTask: /* the URLSessionWebSocketTask is pre-made by apple, thankfully */URLSessionWebSocketTask? // ? is same as Option<T> in Rust 
    // State starts disconnected, but it is visible to public, only modified privarely (setter)
    public private(set) var state: ConnectionState = .disconnected 

    public func connect(to url: String) async throws {
        // TODO: Add logic
    }
}