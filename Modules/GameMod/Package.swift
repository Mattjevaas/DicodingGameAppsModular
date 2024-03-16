// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GameMod",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "GameMod",
            targets: ["GameMod"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/realm/realm-swift.git", branch: "master"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.9.0")),
        .package(path: "../GameDLC"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "GameMod",
            dependencies: [.product(name: "RealmSwift", package: "realm-swift"),
                           .product(name: "Alamofire", package: "Alamofire"),
                           .product(name: "GameDLC", package: "GameDLC"),
        ]),
        .testTarget(
            name: "GameModTests",
            dependencies: ["GameMod"]),
    ]
)
