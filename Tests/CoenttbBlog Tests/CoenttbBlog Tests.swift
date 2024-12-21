//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 13/12/2024.
//

import Foundation
import Testing
@testable import CoenttbBlog
import DependenciesTestSupport

let filenameToResourceUrl: @Sendable (String) -> URL? = { Bundle.module.url(forResource: $0, withExtension: "md") }

@Suite(
    "Blog test suite",
    .dependency(\.filenameToResourceUrl, filenameToResourceUrl)
)
struct TestSuite {
    @Test func test() async throws {
        
    }
}
