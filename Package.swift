// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "Reminder",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "Reminder",
            targets: ["Reminder"]),
    ],
    dependencies: [
        // Firebase Auth
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.15.0"),
        
        // SQLite.swift
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.14.1"),
    ],
    targets: [
        .target(
            name: "Reminder",
            dependencies: [
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "SQLite", package: "SQLite.swift"),
            ],
            path: "Reminder/Sources"),
    ]
)