// swift-tools-version:4.0
// Managed by ice

import PackageDescription

let package = Package(
    name: "Icebox",
    products: [
        .library(name: "Icebox", targets: ["Icebox"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/PathKit", from: "0.9.1"),
    ],
    targets: [
        .target(name: "Icebox", dependencies: ["PathKit"]),
        .testTarget(name: "IceboxTests", dependencies: ["Icebox"]),
    ]
)
