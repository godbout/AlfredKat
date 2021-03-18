// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlfredKat",
    platforms: [.macOS(.v10_13)],
    dependencies: [
        .package(
            name: "AlfredWorkflowScriptFilter",
//            path: "~/Development/AlfredWorkflowScriptFilter"
            url: "https://github.com/godbout/AlfredWorkflowScriptFilter",
            .branch("open-up")
        ),
        .package(
            name: "SwiftSoup",
            url: "https://github.com/scinfu/SwiftSoup",
            from: "2.3.2"
        ),
    ],
    targets: [
        .target(
            name: "AlfredKat",
            dependencies: ["AlfredKatCore"]
        ),
        .target(
            name: "AlfredKatCore",
            dependencies: ["AlfredWorkflowScriptFilter", "SwiftSoup"]
        ),
        .testTarget(
            name: "AlfredKatCoreTests",
            dependencies: ["AlfredKatCore"]
        ),
    ]
)
