// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Category",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(
            name: "Category",
            targets: ["Category"])
    ],
    dependencies: [
        .package(path: "../Meal"),
        .package(url: "https://github.com/JuniaFirdaus/Core.git", .upToNextMajor(from: "1.0.0")),
        .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", from: "10.1.3"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.3.0"))
    ],
    targets: [
        .target(
            name: "Category",
            dependencies: [
                "Meal",
                .product(name: "RealmSwift", package: "Realm"),
                "Core",
                "Alamofire"
            ]),
        .testTarget(
            name: "CategoryTests",
            dependencies: ["Category"])
    ]
)
