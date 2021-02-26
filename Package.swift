// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SnapshotButtonFontVsTitle",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "SnapshotButtonFontVsTitle",
            targets: ["SnapshotButtonFontVsTitle"]),
    ],
    dependencies: [
        .package(name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.8.1")
    ],
    targets: [
        .target(
            name: "SnapshotButtonFontVsTitle",
            dependencies: []),
        .testTarget(
            name: "SnapshotButtonFontVsTitleTests",
            dependencies: [
                "SnapshotTesting",
                "SnapshotButtonFontVsTitle"
            ]),
    ]
)
