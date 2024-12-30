//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 10/12/2024.
//

import Foundation
import Dependencies
import DependenciesMacros
import Date
import Coenttb_Web
import Languages

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
}

public enum BlogKey { }

extension BlogKey: TestDependencyKey {
    public static let testValue: Coenttb_Blog.Client = .init(
        getAll: {
            [
                .preview
            ]
        },
        filenameToResourceUrl: { fileName in
            @Dependency(\.filenameToResourceUrl) var filenameToResourceUrl
            return filenameToResourceUrl(fileName)
        },
        postToRoute: { post in
            nil
        },
        postToFilename: { post in
                        
            return TranslatedString { language in
                
                let baseName = "Blog-\(post.index)"
                
                let previewBaseName = "Preview-Blog-\(post.index)"
                
                return (post.hidden == .preview ? previewBaseName : baseName) + "-\(language.rawValue)"
                
            }
        }
    )
}

extension Client {
    public func urlForPost(post: Blog.Post) -> Translated<URL?> {
        self
            .postToFilename(post)
            .map(self.filenameToResourceUrl)
    }
}

fileprivate enum FilenameToResourceUrlKey: TestDependencyKey {
    nonisolated(unsafe) static var testValue: @Sendable (String) -> URL? = { _ in nil }
}

extension DependencyValues {
    public var filenameToResourceUrl: @Sendable (String) -> URL? {
        get { self[FilenameToResourceUrlKey.self] }
        set { self[FilenameToResourceUrlKey.self] = newValue }
    }
}

extension DependencyValues {
    public var blog: Coenttb_Blog.Client {
        get { self[BlogKey.self] }
        set { self[BlogKey.self] = newValue }
    }
}
