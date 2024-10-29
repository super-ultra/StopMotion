// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "stop-motion-package",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "StopMotionEditor",
            targets: ["StopMotionEditor"]
        )
    ],
    targets: [
        .target(
            name: "StopMotionAssets",
            path: "StopMotionAssets",
            sources: [
                "Sources"
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "StopMotionDrawing",
            path: "StopMotionDrawing",
            sources: [
                "Sources"
            ]
        ),
        .target(
            name: "StopMotionEditor",
            dependencies: [
                "StopMotionAssets",
                "StopMotionDrawing",
                "StopMotionToolbox"
            ],
            path: "StopMotionEditor",
            sources: [
                "Sources"
            ]
        ),
        .target(
            name: "StopMotionToolbox",
            path: "StopMotionToolbox",
            sources: [
                "Sources"
            ]
        )
    ]
)
