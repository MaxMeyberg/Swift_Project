import XCTest
import WebRTC
@testable import SwiftOpenAIRealtime

final class WebRTCTests: XCTestCase {
    
    func testWebRTCFactoryCreation() throws {
        let factory = RTCPeerConnectionFactory()
        XCTAssertNotNil(factory, "RTCPeerConnectionFactory should be created successfully")
    }
    
    func testPeerConnectionCreation() throws {
        let factory = RTCPeerConnectionFactory()
        let config = RTCConfiguration()
        let constraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
        
        let peerConnection = factory.peerConnection(with: config, constraints: constraints, delegate: nil)
        XCTAssertNotNil(peerConnection, "RTCPeerConnection should be created successfully")
    }
}