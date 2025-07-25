//
//  File.swift
//  coenttb-nl-server
//
//  Created by Coen ten Thije Boonkkamp on 19/08/2024.
//

import Coenttb_Web

extension Blog {
    public struct Post: @unchecked Sendable {
        public let id: UUID
        public let index: Int
        public var category: TranslatedString?
        public var publishedAt: Date
        public var image: any HTML
        public var title: String
        public var hidden: Hidden
        public var subtitle: String?
        public var alternateSlug: String?
        public var blurb: String
        public var estimatedTimeToComplete: DateComponents
        public var permission: Permission

        public init(
            id: UUID,
            index: Int,
            category: TranslatedString? = nil,
            publishedAt: Date,
            image: any HTML,
            title: String,
            hidden: Blog.Post.Hidden,
            subtitle: String? = nil,
            alternateSlug: String? = nil,
            blurb: String,
            estimatedTimeToComplete: DateComponents,
            permission: Permission
        ) {
            self.id = id
            self.index = index
            self.category = category
            self.publishedAt = publishedAt
            self.image = image
            self.title = title
            self.hidden = hidden
            self.subtitle = subtitle
            self.alternateSlug = alternateSlug
            self.blurb = blurb
            self.estimatedTimeToComplete = estimatedTimeToComplete
            self.permission = permission
        }
    }
}

extension Blog.Post {
    public var slug: String {
        let sanitizedTitle = self.title
            .lowercased()
            .replacingOccurrences(of: #"[^a-z0-9]+"#, with: "-", options: .regularExpression)
            .trimmingCharacters(in: CharacterSet(charactersIn: "-"))
            .replacingOccurrences(of: "-{2,}", with: "-", options: .regularExpression)

        return "\(self.index)-\(sanitizedTitle)"
    }
}

extension Blog.Post {
    public enum Hidden: Equatable {
        case no
        case preview
        case yesUntil(Date)
        case yes
        public func isCurrentlyHidden(date currentDate: Date) -> Bool {
            switch self {
            case .no:
                false
            case let .yesUntil(date):
                currentDate >= date
            case .yes:
                true
            case .preview:
                true
            }
        }
    }
}

extension Blog.Post {
    public var content: String? {

        @Dependency(\.context) var context

        guard context != .preview
        else {
            return """
            # AI Lorem Ipsum
            Artificial Intelligence (AI) is reshaping how we process and analyze data, but it also raises challenging legal questions, particularly around privacy. In this blog post, Coen ten Thije Boonkkamp explores the intersection of AI and the General Data Protection Regulation (GDPR). From practical guidelines to navigating gray areas, this post provides insights for legal professionals, developers, and policymakers seeking to implement AI in a compliant way.
            """
        }

        @Dependency(\.blog) var blogClient
        @Dependency(\.language) var language
        @Dependency(\.languages) var languages

        guard self.hidden != .yes
        else {
            return nil
        }

        return blogClient.filenameToResourceUrl(blogClient.postToFilename(self)(language))
            .flatMap { try? Data(contentsOf: $0) }
            .flatMap { String(data: $0, encoding: .utf8) }
    }
}

extension Blog.Post {
    public enum Permission: Equatable {
      case free
//      case freeDuring(Range<Date>)
      case subscriberOnly
    }
}
