// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlfredKat",
    platforms: [.macOS(.v10_13)],
    dependencies: [
        .package(
            name: "AlfredWorkflowScriptFilter",
            url: "https://github.com/godbout/AlfredWorkflowScriptFilter",
            from: "1.0.0"
        ),
        .package(
            name: "SwiftSoup",
            url: "https://github.com/scinfu/SwiftSoup",
            from: "2.3.2"
        ),
        .package(
            name: "AlfredWorkflowUpdater",
            url: "https://github.com/godbout/AlfredWorkflowUpdater",
            from: "0.1.0"
        ),
    ],
    targets: [
        .target(
            name: "AlfredKat",
            dependencies: ["AlfredKatCore"]
        ),
        .target(
            name: "AlfredKatCore",
            dependencies: ["AlfredWorkflowScriptFilter", "SwiftSoup", "AlfredWorkflowUpdater"]
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
