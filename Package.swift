// swift-tools-version:6.0

import Foundation
import PackageDescription

extension String {
    static let coenttbBlog: Self = "Coenttb Blog"
}

extension Target.Dependency {
    static var coenttbBlog: Self { .target(name: .coenttbBlog) }
}

extension Target.Dependency {
    static var coenttbWeb: Self { .product(name: "Coenttb Web", package: "coenttb-web") }
    static var coenttbVapor: Self { .product(name: "Coenttb Vapor", package: "coenttb-server") }
    static var dependenciesMacros: Self { .product(name: "DependenciesMacros", package: "swift-dependencies") }
    static var dependenciesTestSupport: Self { .product(name: "DependenciesTestSupport", package: "swift-dependencies") }
    static var either: Self { .product(name: "Either", package: "swift-prelude") }
}

let package = Package(
    name: "coenttb-blog",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(name: .coenttbBlog, targets: [.coenttbBlog]),
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/coenttb-web", branch: "main"),
        .package(url: "https://github.com/coenttb/coenttb-server", branch: "main"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.1.5"),
        .package(url: "https://github.com/pointfreeco/swift-prelude", from: "0.6.0"),
    ],
    targets: [
        .target(
            name: .coenttbBlog,
            dependencies: [
                .dependenciesMacros,
                .either,
                .coenttbWeb,
                .coenttbVapor,
            ]
        ),
        .testTarget(
            name: .coenttbBlog + " Tests",
            dependencies: [
                .coenttbBlog,
                .dependenciesTestSupport
            ],
            resources: [ .process("Resources") ]
        )
    ],
    swiftLanguageModes: [.v6]
)
