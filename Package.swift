// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlfredKat",
    targets: [
        .target(
            name: "AlfredKat",
            dependencies: ["AlfredKatCore"]
        ),
        .target(
            name: "AlfredKatCore",
            dependencies: []
        ),
        .testTarget(
            name: "AlfredKatCoreTests",
            dependencies: ["AlfredKatCore"]
        ),
    ]
)
