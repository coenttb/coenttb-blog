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
                Cards {
                    for post in posts.suffix(3).reversed() {
                        Blog.Post.Card(post)
                    }
                }
            } title: {
                PageModuleSeeAllTitle(
                    title: TranslatedString(
                        dutch: "recente posts",
                        english: "recent posts"
                    ).capitalizingFirstLetter().description,
                    seeAllURL: seeAllURL.absoluteString
                )
                .padding(bottom: .rem(2))
            }
        }
    }
}



#if DEBUG && canImport(SwiftUI)

import SwiftUI

#Preview {
    
    let posts: [Blog.Post] = {
        @Dependency(\.blog.client) var blogClient
        return blogClient.getAll()
    }()
    
    let card: some HTML = Blog.FeaturedModule(posts: posts, seeAllURL: .applicationDirectory)
    
    HTMLDocument {
        card
    }
    .frame(width: 1024)
}

#endif
