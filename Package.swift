// swift-tools-version:5.5

import PackageDescription

let package = Package(name: "qrect", platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15)
    ], products: [
        .library(name: "QRect", targets: [
            "QRect"
        ]),
        .executable(name: "qrect-cli", targets: [
            "QRectCLI"
        ])
    ], dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .branch("main"))
    ], targets: [
        .target(name: "QRect", dependencies: []),
        .executableTarget(name: "QRectCLI", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            "QRect"
        ]),
        .testTarget(name: "QRectTests", dependencies: [
            "QRect"
        ])
    ])
