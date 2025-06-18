// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "SwiftOpenAIRealtime",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(name: "SwiftOpenAIRealtime", targets: ["SwiftOpenAIRealtime"]),
        .executable( name: "VoiceChat", targets: ["VoiceChat"])
    ],
    dependencies: [
        .package(url: "https://github.com/stasel/WebRTC.git", .upToNextMajor(from: "137.0.0"))
    ],
    targets: [
        .target(
            name: "SwiftOpenAIRealtime",
            dependencies: ["WebRTC"]
        ),
        .executableTarget(
            name: "VoiceChat",
            dependencies: ["SwiftOpenAIRealtime"]
        ),
        .testTarget(
            name: "SwiftOpenAIRealtimeTests",
            dependencies: ["SwiftOpenAIRealtime", "WebRTC"]
        ),
    ]
)
