//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 13/12/2024.
//

import Coenttb_Web

extension Blog.Post {
    public struct View: HTML {
        
        let post: Blog.Post
        
        @Dependency(\.locale) var locale
        
        public init(post: Blog.Post) {
            self.post = post
        }
        
        public var body: some HTML {
            div {
                div {
                    AnyHTML(post.image)
                        .position(
                            .absolute,
                            top: .zero,
                            right: .zero,
                            bottom: .zero,
                            left: .zero
                        )
                }
                .clipPath(.circle(.percent(50)))
                .position(.relative)
                .size(.rem(10))
            }
            .padding(
                top: .length(.large)
            )
            .flexContainer(
                justification: .center,
                itemAlignment: .center
            )

            if let content = post.content {
                PageModule(theme: .content) {
                    TextArticle {
                        div {
                            HTMLText("Blog \(post.index)\(post.category.map { " \($0.description)" } ?? "") - \(post.publishedAt.formatted(date: .complete, time: .omitted))")
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

#if canImport(SwiftUI)
import SwiftUI
#Preview {
    HTMLDocument.modern {
        Blog.Post.View(post: .preview)
    }
}

#endif
