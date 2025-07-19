//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 13/12/2024.
//

import Coenttb_Web

extension Blog.Post {
    public struct View: HTML {

        let index: Int
        let image: any HTML
        let category: TranslatedString?
        let content: String?
        let publishedAt: Date
        
        public init(
            index: Int,
            image: any HTML,
            category: TranslatedString?,
            content: String?,
            publishedAt: Date
        ) {
            self.index = index
            self.image = image
            self.category = category
            self.content = content
            self.publishedAt = publishedAt
        }

        public var body: some HTML {
            Circle {
                AnyHTML(image)
                    .objectPosition(.twoValues(.percentage(50), .percentage(50)))
            }

            .position(.relative)
            .size(.rem(10)) // Make sure this is 10rem, not smaller
            .padding(top: .length(.large))
            .flexContainer(
                justification: .center,
                itemAlignment: .center
            )

            if let content = content {
                PageModule(theme: .content) {
                    TextArticle {
                        div {
                            HTMLText("Blog \(index)\(category.map { " \($0.description)" } ?? "") - \(publishedAt.formatted(date: .complete, time: .omitted))")
                        }
                        .color(.text.tertiary)
                        .font(.body(.small))

                        HTMLMarkdown {
                            content
                        }
                    }
                    .width(.percent(100))
                }
            }
        }
    }
}

extension Blog.Post.View {
    public init(post: Blog.Post) {
        self = .init(
            index: post.index,
            image: post.image,
            category: post.category,
            content: post.content,
            publishedAt: post.publishedAt
        )
    }
}

extension ObjectPosition {
    static let defaultObjectPosition: Self = .twoValues(.percentage(50), .percentage(50))
}

#if DEBUG && canImport(SwiftUI)
import SwiftUI
#Preview {
    HTMLDocument {
        Blog.Post.View(post: .preview)
    }
}

#endif
