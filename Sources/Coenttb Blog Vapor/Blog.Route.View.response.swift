//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 16/12/2024.
//

import Coenttb_Blog
import Coenttb_Vapor
import Coenttb_Web

extension Blog.Route.View {
    public static func response(
        route: Blog.Route.View
    ) async throws -> any HTML {
        switch route {
        case .index:
            
            @Dependency(\.blog.configuration.titleBlurb) var titleBlurb
            @Dependency(\.blog.configuration.companyXComHandle) var companyXComHandle
            
            let header = {
                PageHeader(
                    title: .blog.capitalizingFirstLetter().description,
                    blurb: {
                        titleBlurb
                    }
                ) {
                    HTMLGroup {
                        "\(String.curious_what_is_next.description.capitalizingFirstLetter())".questionmark
                            .color(.text.secondary)

                        HTMLText(" ")

                        if let companyXComHandle {
                            Link(String.follow_me_on_Twitter.capitalizingFirstLetter().period.description, href: .init("https://x.com/\(companyXComHandle)"))
                                .linkUnderline(true)
                        }
                    }
                }
            }
            
            @Dependency(\.blog.client.getAll) var getAll
            
            let posts = getAll()

            switch posts.count {
            case 0:
                return header()
            case 1:
                
                return try await response(
                    route: .post(.left(posts[0].slug))
                )
            default:
                return HTMLGroup {
                    header()

                    Blog.Route.View.Index(
                        posts: posts
                    )
                }
            }

        case .post(let identifier):

            @Dependency(\.blog.client.getCurrentUser) var getCurrentUser
            @Dependency(\.blog.client.getAll) var getAll
            
            let currentUser = getCurrentUser()
            let posts = getAll()

            guard let post = posts.lazy.first(where: {
                switch identifier {
                case .left(let string):
                    $0.slug == string
                case .right(let int):
                    $0.index == int
                }
            }) else {
                return try await response(
                    route: .index
                )
            }

            guard !(post.permission == .subscriberOnly && currentUser?.accessToBlog != true)
            else {
                return Header(1) {
                    TranslatedString(
                        dutch: "Alleen voor subscribers",
                        english: "Subscriber only"
                    )
                }
            }
            
            @Dependency(\.blog.configuration.newsletterSection) var newsletterSection

            return HTMLGroup {
                Blog.Post.View(post: post)

                if let newsletterSection {
                    AnyHTML(newsletterSection())
                }
            }
        }
    }
}
