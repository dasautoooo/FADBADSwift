// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FADBADSwift",
    products: [
        .library(
            name: "FADBADSwift",
            targets: ["FADBADSwift"]),
    ],
    targets: [
        .target(
            name: "FADBADSwift",
            dependencies: ["fadbadxx"],
            swiftSettings: [.interoperabilityMode(.Cxx)]
        ),
        .target(name: "fadbadxx"),
        .testTarget(
            name: "FADBADSwiftTests",
            dependencies: ["FADBADSwift"],
            swiftSettings: [.interoperabilityMode(.Cxx)]
        ),
    ],
    cxxLanguageStandard: .cxx20
)
