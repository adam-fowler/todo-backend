// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "todo-backend",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(name: "todo-backend", targets: ["todo-backend"]),
    ], 
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", .branch("main")),
        .package(url: "https://github.com/hummingbird-project/hummingbird-fluent.git", .branch("main")),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.3.0")
    ],
    targets: [
        .target(name: "todo-backend", dependencies: [
            .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
            .product(name: "Hummingbird", package: "hummingbird"),
            .product(name: "HummingbirdFluent", package: "hummingbird-fluent"),
            .product(name: "HummingbirdFoundation", package: "hummingbird"),
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
        ]),
    ]
)
