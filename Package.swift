// swift-tools-version:6.0

import Foundation
import PackageDescription

extension String {
    static let coenttbBlog: Self = "CoenttbBlog"
}

extension Target.Dependency {
    static var coenttbBlog: Self { .target(name: .coenttbBlog) }
}

extension Target.Dependency {
    static var coenttbHtml: Self { .product(name: "CoenttbHTML", package: "coenttb-html") }
    static var coenttbMarkdown: Self { .product(name: "CoenttbMarkdown", package: "coenttb-html") }
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
    static var dependenciesMacros: Self { .product(name: "DependenciesMacros", package: "swift-dependencies") }
    static var dependenciesTestSupport: Self { .product(name: "DependenciesTestSupport", package: "swift-dependencies") }
    static var swiftDate: Self { .product(name: "Date", package: "swift-date") }
    static var language: Self { .product(name: "Languages", package: "swift-language") }
    static var logging: Self { .product(name: "Logging", package: "swift-log") }
    static var codable: Self { .product(name: "MacroCodableKit", package: "macro-codable-kit") }
    static var memberwiseInit: Self { .product(name: "MemberwiseInit", package: "swift-memberwise-init-macro") }
    static var environmentVariables: Self { .product(name: "EnvironmentVariables", package: "swift-environment-variables") }
    static var urlRouting: Self { .product(name: "URLRouting", package: "swift-url-routing") }
    static var either: Self { .product(name: "Either", package: "swift-prelude") }
    static var vapor: Self { .product(name: "Vapor", package: "Vapor") }
    static var coenttbWebTranslations: Self { .product(name: "CoenttbWebTranslations", package: "coenttb-web") }
    static var coenttbWebHTML: Self { .product(name: "CoenttbWebHTML", package: "coenttb-web") }
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
        .package(url: "https://github.com/coenttb/coenttb-html", branch: "main"),
        .package(url: "https://github.com/coenttb/coenttb-web", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-date", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-environment-variables.git", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-language.git", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-web", branch: "main"),
        .package(url: "https://github.com/coenttb/macro-codable-kit.git", branch: "main"),
        .package(url: "https://github.com/gohanlon/swift-memberwise-init-macro", from: "0.3.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.1.5"),
        .package(url: "https://github.com/pointfreeco/swift-url-routing", from: "0.6.0"),
        .package(url: "https://github.com/pointfreeco/swift-prelude", from: "0.6.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.102.1"),
    ],
    targets: [
        .target(
            name: .coenttbBlog,
            dependencies: [
                .urlRouting,
                .dependencies,
                .memberwiseInit,
                .codable,
                .dependenciesMacros,
                .language,
                .swiftDate,
                .vapor,
                .coenttbHtml,
                .coenttbMarkdown,
                .either,
                .coenttbWebTranslations,
                .coenttbWebHTML
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
