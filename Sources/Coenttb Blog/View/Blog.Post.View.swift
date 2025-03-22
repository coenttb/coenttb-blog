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
                    AnyHTML(post.image.loading(.lazy))
                        .position(.absolute, top: 0, right: 0, bottom: 0, left: 0)
                }
                .clipPath(.circle(50.percent))
                .position(.relative)
                .size(10.rem)
            }
            .padding(top: .large)
            .flexContainer(
                justification: .center,
                itemAlignment: .center
            )

            if let content = post.content {
                PageModule(theme: .content) {
                    TextArticle {
                        div {
                            HTMLText("Blog \(post.index)\(post.category.map { " \($0.description)" } ?? "") \(post.publishedAt.formatted(date: .complete, time: .omitted))")
                        }
                        .color(.text.tertiary)
                        .fontStyle(.body(.small))
                        
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
    HTMLPreview.modern {
        Blog.Post.View(post: .preview)
    }
}

#endif
