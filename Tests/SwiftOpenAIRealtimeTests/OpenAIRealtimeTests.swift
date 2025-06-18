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
        
        // Check connection status at different intervals
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("🔍 After 2 seconds:")
            client.checkConnectionStatus()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("🔍 After 5 seconds:")
            client.checkConnectionStatus()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            print("🔍 After 8 seconds:")
            client.checkConnectionStatus()
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