//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 10/12/2024.
//

import Coenttb_Web
import DateExtensions
import Dependencies
import DependenciesMacros
import Translating

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension Blog {
    @DependencyClient
    public struct Client: @unchecked Sendable {
        @DependencyEndpoint
        public var getAll: () -> [Blog.Post] = { [] }

        @DependencyEndpoint
        public var filenameToResourceUrl: (String) -> URL? = { _ in nil }

        @DependencyEndpoint
        public var postToRoute: (Blog.Post) -> URL? = { _ in nil }

        @DependencyEndpoint
        public var postToFilename: (Blog.Post) -> TranslatedString = { _ in .init("") }
        
        @DependencyEndpoint
        public var getCurrentUser: @Sendable () -> (newsletterSubscribed: Bool, accessToBlog: Bool)?
    }
}

extension Blog.Client: TestDependencyKey {
    public static let testValue: Blog.Client = .init(
        getAll: {
            [
                .preview,
                .preview2,
                .preview
            ]
        },
        filenameToResourceUrl: { fileName in
            @Dependency(\.filenameToResourceUrl) var filenameToResourceUrl
            return filenameToResourceUrl(fileName)
        },
        postToRoute: { _ in
            nil
        },
        postToFilename: { post in

            return TranslatedString { language in

                let baseName = "Blog-\(post.index)"

                let previewBaseName = "Preview-Blog-\(post.index)"

                return (post.hidden == .preview ? previewBaseName : baseName) + "-\(language.rawValue)"
            }
        },
        getCurrentUser: {
//            (newsletterSubscribed: Bool, accessToBlog: Bool)
            nil
        }
    )
}

extension Blog.Client {
    public func urlForPost(post: Blog.Post) -> Translated<URL?> {
        self
            .postToFilename(post)
            .map(self.filenameToResourceUrl)
    }
}

private enum FilenameToResourceUrlKey: TestDependencyKey {
    static let testValue: @Sendable (String) -> URL? = { _ in nil }
}

extension DependencyValues {
    public var filenameToResourceUrl: @Sendable (String) -> URL? {
        get { self[FilenameToResourceUrlKey.self] }
        set { self[FilenameToResourceUrlKey.self] = newValue }
    }
}

