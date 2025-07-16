//
//  File.swift
//  coenttb-nl-server
//
//  Created by Coen ten Thije Boonkkamp on 19/08/2024.
//

import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
@dynamicMemberLookup
public struct Blog: Sendable {
    public var client: Blog.Client
    public var configuration: Blog.Configuration

    public init(
        client: Blog.Client,
        configuration: Blog.Configuration
    ) {
        self.client = client
        self.configuration = configuration
    }

    public subscript<T>(dynamicMember keyPath: WritableKeyPath<Blog.Client, T>) -> T {
        self.client[keyPath: keyPath]
    }

    public subscript<T>(dynamicMember keyPath: WritableKeyPath<Blog.Configuration, T>) -> T {
        self.configuration[keyPath: keyPath]
    }
}

extension Blog: TestDependencyKey {
    public static var testValue: Blog {
        .init(
            client: .testValue,
            configuration: .testValue
        )
    }
}

extension DependencyValues {
    public var blog: Blog {
        get { self[Blog.self] }
        set { self[Blog.self] = newValue }
    }
}
