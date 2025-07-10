//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 10/12/2024.
//

import Coenttb_Web

extension Blog.Post {
    public struct Card: HTML {
        @Dependency(\.date.now) var now
        @Dependency(\.language) var language
        
        let post: Blog.Post
        
        let href: URL?
        
        public init(
            _ post: Blog.Post
        ) {
            self.post = post
            @Dependency(\.blog) var blogClient
            self.href = blogClient.postToRoute(post)
        }
        
        public var body: some HTML {
            CoenttbHTML.Card {
                VStack {
                    
                    VStack(
                        spacing: .rem(0.5)
                    ) {
                        div {
                            HTMLText("Blog \(post.index)\(post.category.map { " \($0.description)" } ?? "") - \(post.publishedAt.formatted(date: .complete, time: .omitted))")
                        }
                        .color(.text.tertiary)
                        .font(.body(.small))
                        
                        div {
                            if let href {
                                Header(4) {
                                    Link(href: .init(href.absoluteString)) {
                                        HTMLText(post.title)
                                        if let subtitle = post.subtitle {
                                            ":"
                                            br()
                                            HTMLText(subtitle)
                                        }
                                    }
                                    .linkColor(.text.primary)
                                }
                            }
                        }
                    }
                    
                    HTMLMarkdown(post.blurb)
                        .color(.text.primary)
                        .linkStyle(.init(underline: true))
                        .dependency(\.color.text.link, .gray400.withDarkColor(.gray650))               
                }
            }
            header: {
                if let href {
                    CoenttbHTML.Link(href: .init(href.absoluteString)) {
                        div {
                            div {
                                AnyHTML(
                                    post.image
                                )
                                
                                    .width(.percent(100))
                                    .height(.percent(100))
//                                    .objectFit(.cover)
                            }
                            .position(
                                .absolute,
                                top: .zero,
                                right: nil,
                                bottom: nil,
                                left: .zero,
                            )
                            .width(.percent(100))
                            .height(.percent(100))
//                            .size(
//                                width: .percent(100),
//                                height: .percent(100)
//                            )
                        }
                        .position(.relative)
                        .width(.percent(100))
                        .height(.px(300))
//                        .size(
//                            width: .percent(100),
//                            height: .px(300)
//                        )
                        .overflow(.hidden)
                    }
                }
                
            }
            footer: {
                Blog.Post.Card.Footer {
                    switch post.permission {
                    case .free:
                        Label(fa: "lock-open") {
                            String.free
                        }
                    case .subscriberOnly:
                        Label(fa: "lock") {
                            String.subscriber_only
                        }
                    }
                    
                    Label(fa: "clock") {
                        TranslatedString(self.post.estimatedTimeToComplete)
                        
                    }
                }
                .fontSize(.secondary)
            }
            .backgroundColor(.cardBackground)
        }
    }
}

extension Blog.Post.Card {
    private struct Footer<Content: HTML>: HTML {
        @HTMLBuilder let content: Content
        var body: some HTML {
            HStack(alignment: .center) {
                content
            }
            .marginTop(.auto)
            .color(.gray650.withDarkColor(.gray400))
            .linkColor(.gray650.withDarkColor(.gray400))
        }
    }
}




extension Blog.Post {
    static let preview: Self = .init(
        id: .init(),
        index: 1,
        publishedAt: .init(timeIntervalSince1970: 1_523_872_623),
        image: Square(),
        title: "Mock Blog post",
        hidden: .no,
        blurb: """
        This is the blurb to a mock blog post. This should just be short and to the point, using \
        only plain text, no markdown.
        """,
        estimatedTimeToComplete: 10.minutes,
        permission: .free
    )
}

struct Square: HTML {
    var body: some HTML {
        div {}
            .backgroundColor(.color(.blue))
            .width(.percent(100))
            .height(.px(300))  // Match the header height exactly
            .display(.block)
            .inlineStyle("max-width", "100%")
    }
}

#if DEBUG && canImport(SwiftUI)
import SwiftUI

#Preview("Card") {
    HTMLDocument {
        Blog.Post.Card(.preview)
    }
    .frame(height: 800)
}

#Preview("Square") {
    HTMLDocument {
        Square()
    }
}

#endif
