// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

import PackageDescription

let package = Package(
    name: "DynamicToast",
    platforms: [.iOS(.v18)],
    products: [
        .library(name: "DynamicToast", targets: ["DynamicToast"]),
    ],
    dependencies: [
        .package(url: "https://github.com/phosphor-icons/swift", exact: "2.1.0")
    ],
    targets: [
        .target(
            name: "DynamicToast",
            dependencies: [
                .product(name: "PhosphorSwift", package: "swift")
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
    ]
)
