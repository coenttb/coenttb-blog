//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 13/12/2024.
//

import Foundation
import Testing
import Dependencies
@testable import CoenttbBlog
import DependenciesTestSupport

let filenameToResourceUrl: @Sendable (String) -> URL? = { Bundle.module.url(forResource: $0, withExtension: "md") }

@Suite(
    "Blog test suite",
    .dependency(\.filenameToResourceUrl, filenameToResourceUrl)
)
struct TestSuite {
    @Test func test() async throws {
        @Dependency(\.blog.getAll) var getAll
        
        let x = getAll()
        
        #expect(x.count == 1)
    }
}
