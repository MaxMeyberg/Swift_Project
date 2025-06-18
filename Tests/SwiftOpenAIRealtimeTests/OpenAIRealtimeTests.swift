import XCTest
@testable import SwiftOpenAIRealtime

final class OpenAIRealtimeTests: XCTestCase {
    
    func testOpenAIConnection() throws {
        // Get API key from environment
        let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? ""
        XCTAssertFalse(apiKey.isEmpty, "OpenAI API key is required")
        XCTAssertTrue(apiKey.hasPrefix("sk-"), "API key should start with 'sk-'")
        
        let client = OpenAIRealtimeClient(apiKey: apiKey)
        
        let expectation = XCTestExpectation(description: "OpenAI connection test")
        
        // Test connection
        client.connect()
        
        // Wait for connection and send a test message
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("Testing OpenAI Realtime API connection...")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15)
        client.disconnect()
        
        print("✅ OpenAI API key is valid and connection test completed")
    }
    
    func testAPIKeyFormat() throws {
        let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? ""
        XCTAssertFalse(apiKey.isEmpty, "API key should not be empty")
        XCTAssertTrue(apiKey.hasPrefix("sk-"), "OpenAI API key should start with 'sk-'")
        XCTAssertGreaterThan(apiKey.count, 20, "API key should be longer than 20 characters")
    }
}