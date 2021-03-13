// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlfredKat",
    dependencies: [
        .package(path: "~/Development/AlfredWorkflowScriptFilter")
    ],
    targets: [
        .target(
            name: "AlfredKat",
            dependencies: ["AlfredKatCore"]
        ),
        .target(
            name: "AlfredKatCore",
            dependencies: ["AlfredWorkflowScriptFilter"]
        ),
        .testTarget(
            name: "AlfredKatCoreTests",
            dependencies: ["AlfredKatCore"]
        ),
    ]
)
