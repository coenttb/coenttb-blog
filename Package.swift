// swift-tools-version:6.0

import Foundation
import PackageDescription

extension String {
    static let coenttbBlog: Self = "Coenttb Blog"
    static let coenttbBlogVapor: Self = "Coenttb Blog Vapor"
}

extension Target.Dependency {
    static var coenttbBlog: Self { .target(name: .coenttbBlog) }
    static var coenttbBlogVapor: Self { .target(name: .coenttbBlogVapor) }
}

extension Target.Dependency {
    static var coenttbWeb: Self { .product(name: "Coenttb Web", package: "coenttb-web") }
    static var coenttbVapor: Self { .product(name: "Coenttb Vapor", package: "coenttb-server-vapor") }
    static var dependenciesMacros: Self { .product(name: "DependenciesMacros", package: "swift-dependencies") }
    static var dependenciesTestSupport: Self { .product(name: "DependenciesTestSupport", package: "swift-dependencies") }
    static var either: Self { .product(name: "Either", package: "swift-prelude") }
    static var pointfreeHtmlTestSupport: Self { .product(name: "PointFreeHTMLTestSupport", package: "pointfree-html") }
}

let package = Package(
    name: "coenttb-blog",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(name: .coenttbBlog, targets: [.coenttbBlog]),
        .library(name: .coenttbBlogVapor, targets: [.coenttbBlogVapor])
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/swift-html-css-pointfree", branch: "main"),
        .package(url: "https://github.com/coenttb/coenttb-web", branch: "main"),
        .package(url: "https://github.com/coenttb/pointfree-html", from: "2.0.0"),
        .package(url: "https://github.com/coenttb/coenttb-server-vapor", branch: "main"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.9.2"),
        .package(url: "https://github.com/pointfreeco/swift-prelude", branch: "main")
    ],
    targets: [
        .target(
            name: .coenttbBlog,
            dependencies: [
                .dependenciesMacros,
                .either,
                .coenttbWeb
            ]
        ),
        .target(
            name: .coenttbBlogVapor,
            dependencies: [
                .coenttbBlog,
                .dependenciesMacros,
                .either,
                .coenttbWeb,
                .coenttbVapor
            ]
        ),
        .testTarget(
            name: .coenttbBlog.tests,
            dependencies: [
                .coenttbBlog,
                .dependenciesTestSupport,
                .pointfreeHtmlTestSupport
            ],
            resources: [ .process("Resources") ]
        )
    ],
    swiftLanguageModes: [.v6]
)

extension String { var tests: String { self + " Tests" } }
