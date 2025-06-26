//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 13/12/2024.
//

import Coenttb_Web

extension Blog {
    public struct AllPostsModule: HTML {
        
        let posts: [Blog.Post]
        
        public init(posts: [Blog.Post]) {
            self.posts = posts
        }
        
        var columns: [Int] {
            switch posts.count {
            case ...1: [1]
            case 2: [1, 1]
            default: [1, 1, 1]
            }
        }
        
        @Dependency(\.language) var language
        
        public var body: some HTML {
            PageModule(
                theme: .content
            ) {
                VStack {
                    LazyVGrid(
                        columns: [.desktop: columns],
                        horizontalSpacing: .rem(1),
                        verticalSpacing: .rem(1)
                    ) {
                        HTMLForEach(posts.reversed()) { post in
                            Blog.Post.Card(post)
                                .maxWidth(.rem(24), media: .desktop)
                                .margin(
                                    top: .rem(1),
                                    right: .zero,
                                    bottom: .rem(2),
                                    left: .zero
                                )
                        }
                    }
                }
            } title: {
                PageModuleTitle(title: String.all_posts.capitalizingFirstLetter().description)
                    .padding(bottom: .rem(2))
            }
        }
    }
}


public struct PageModuleTitle<Title: HTML>: HTML {
    
    let title: Title
    
    public init(
        @HTMLBuilder title: () -> Title
    ) {
        self.title = title()
    }
    
    public init(title: String) where Title == CoenttbHTML.Header<HTMLText> {
        self.title = Header(3) { HTMLText(title) }
    }
    
    public var body: some HTML {
        div {
            title
        }
        .width(.percent(100))
        .flexContainer(
            direction: .row,
            wrap: .nowrap,
            justification: .center,
            itemAlignment: .center
        )
        .flexItem(basis: .percent(100))
    }
}
