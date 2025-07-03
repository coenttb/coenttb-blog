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
//            div {
//                div {
//                    div {
//                        AnyHTML(post.image)
//                            .objectFit(.cover)
//                            .objectPosition(.twoValues(.percentage(50), .percentage(50)))
//                            .height(.percent(100))
//                            .width(.percent(100))
//                            .maxWidth(.percent(100))
//                            .borderStyle(BorderStyle.none)
//                    }
//                    .position(.absolute)
//                    .width(.percent(100))
//                    .height(.percent(100))
//                    .display(.block)
//                }
//                .clipPath(.circle(.percent(50)))
//                .position(
//                    .relative
//                )
//                .width(.rem(10))
//                .height(.rem(10))
//            }
            
            Circle {
                AnyHTML(post.image)
            }
            
            .position(.relative)
            .size(.rem(10)) // Make sure this is 10rem, not smaller
            .padding(top: .length(.large))
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

struct Circle: HTML {
    
    @HTMLBuilder let content: () -> any HTML
    
    let width: LengthPercentage = .rem(10)
    let height: LengthPercentage = .rem(10)
    
    var body: some HTML {
        div {
            div {
                div {
                    AnyHTML(content())
                        .objectFit(.cover)
                        .objectPosition(.twoValues(.percentage(50), .percentage(50)))
                        .height(.percent(100))
                        .width(.percent(100))
                        .maxWidth(.percent(100))
                        .borderStyle(BorderStyle.none)
                }
                .position(.absolute)
                .width(.percent(100))
                .height(.percent(100))
                .display(.block)
            }
            .clipPath(.circle(.percent(50)))
            .position(.relative)
            .width(.lengthPercentage(width))
            .height(.lengthPercentage(height))
        }
    }
}

#if DEBUG && canImport(SwiftUI)
import SwiftUI
#Preview {
    HTMLDocument {
        Blog.Post.View(post: .preview)
    }
}

#endif
