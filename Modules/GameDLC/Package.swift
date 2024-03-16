// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GameDLC",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "GameDLC",
            targets: ["GameDLC"]),
    ],
    dependencies: [
        .package(path: "../Core"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "GameDLC",
            dependencies: [.product(name: "Core", package: "Core"),
        ]
        ),
        .testTarget(
            name: "GameDLCTests",
            dependencies: ["GameDLC"]),
    ]
)
