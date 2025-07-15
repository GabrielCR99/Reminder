// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "Reminder",
    platforms: [
        .iOS("13.4"),
        .macOS("10.15"),
    ],
    products: [
        .library(
            name: "Reminder",
            targets: ["Reminder"])
    ],
    dependencies: [
        // Firebase Auth
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.15.0"),

        // SQLite.swift
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.14.1"),

        // Lottie
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.5.1")
    ],
    targets: [
        .target(
            name: "Reminder",
            dependencies: [
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "SQLite", package: "SQLite.swift"),
                .product(name: "Lottie", package: "lottie-spm")
            ],
            path: "Reminder/Sources",
        )
    ]
)
