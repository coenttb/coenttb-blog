//
//  File.swift
//  coenttb-nl-server
//
//  Created by Coen ten Thije Boonkkamp on 19/08/2024.
//

import Coenttb_Web

extension Blog {
    public struct FeaturedModule: HTML {

        let posts: [Blog.Post]
        let seeAllURL: URL
        
        public init(
            posts: [Blog.Post],
            seeAllURL: URL
        ) {
            self.posts = posts
            self.seeAllURL = seeAllURL
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
                        HTMLForEach(posts.suffix(3).reversed()) { post in
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
                PageModuleSeeAllTitle(title: String.all_posts.capitalizingFirstLetter().description, seeAllURL: seeAllURL.absoluteString)
                    .padding(bottom: .rem(2))
            }
        }
    }
}


#if DEBUG && canImport(SwiftUI)

import SwiftUI


#Preview {

    let posts: [Blog.Post] = {
        @Dependency(\.blog) var blogClient
        return blogClient.getAll()
    }()
        
    let card: some HTML = Blog.FeaturedModule(posts: posts, seeAllURL: .applicationDirectory)
    
    HTMLDocument {
        card
    }
    .frame(width: 1024)
}

#endif
