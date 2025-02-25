// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlfredKat",
    platforms: [.macOS("10.15.7")],
    dependencies: [
        .package(
            url: "https://github.com/godbout/AlfredWorkflowScriptFilter",
            from: "1.0.0"
        ),
        .package(
            url: "https://github.com/scinfu/SwiftSoup",
            from: "2.7.7"
        ),
    ],
    targets: [
        .executableTarget(
            name: "AlfredKat",
            dependencies: ["AlfredKatCore"]
        ),
        .target(
            name: "AlfredKatCore",
            dependencies: ["AlfredWorkflowScriptFilter", "SwiftSoup"]
        ),
        .testTarget(
            name: "AlfredKatCoreTests",
            dependencies: ["AlfredKatCore"],
            resources: [
                .process("Resources"),
            ]
        ),
    ]
)
