// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "cookie-cleaner",
    dependencies: [
        .package(url: "https://github.com/interstateone/BinaryCookies.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "cookie-cleaner",
            dependencies: ["BinaryCookies"]),
    ]
)

