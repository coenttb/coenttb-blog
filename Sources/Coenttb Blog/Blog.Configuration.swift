//
//  File.swift
//  coenttb-blog
//
//  Created by Coen ten Thije Boonkkamp on 16/07/2025.
//

import Foundation
import Dependencies
import DependenciesMacros
import Coenttb_Web

extension Blog {
    public struct Configuration: Sendable {
        public var titleBlurb: TranslatedString
        public var companyXComHandle: String?
        public var newsletterSection: (@Sendable () -> any HTML)?
        
        public init(
            titleBlurb: TranslatedString,
            companyXComHandle: String? = nil,
            newsletterSection: (@Sendable() -> any HTML)? = nil
        ) {
            self.titleBlurb = titleBlurb
            self.companyXComHandle = companyXComHandle
            self.newsletterSection = newsletterSection
        }
    }
}

extension Blog.Configuration: TestDependencyKey {
    static public var testValue: Blog.Configuration {
        .init(
            titleBlurb: "Your favorite blog",
            companyXComHandle: "coenttb",
            newsletterSection: nil
        )
    }
}
