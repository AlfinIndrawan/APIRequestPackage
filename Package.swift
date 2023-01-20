// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APIRequest",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "APIRequest",
            targets: ["APIRequest"]),
    ],
    dependencies: [
      .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0"),

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "APIRequest",
            dependencies: [
              .product(name: "RxCocoa", package: "RxSwift")]
        ),
        .testTarget(
            name: "APIRequestTests",
            dependencies: ["APIRequest"]),
    ]
)
