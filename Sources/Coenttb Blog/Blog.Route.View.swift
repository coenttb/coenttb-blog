//
//  File.swift
//
//
//  Created by Coen ten Thije Boonkkamp on 06/07/2023.
//

import Coenttb_Web
@preconcurrency import Either

extension Blog.Route {
    public enum View: Codable, Hashable, Sendable {
        case index
        case post(Either<String, Int>)
    }
}

extension Blog.Route.View {
    public static func post(slug: String) -> Blog.Route.View {
        .post(.left(slug))
    }
    public static func post(_ slug: String) -> Blog.Route.View {
        .post(.left(slug))
    }
    public static func post(id: Int) -> Blog.Route.View {
        .post(.right(id))
    }
    public static func post(_ id: Int) -> Blog.Route.View {
        .post(.right(id))
    }
    public static func post(_ post: Blog.Post) -> Blog.Route.View {
        .post(slug: post.slug)
    }
}

extension Blog.Route.View {
    public struct Router: ParserPrinter {

        public init() {}

        public var body: some URLRouting.Router<Blog.Route.View> {
            OneOf {

                URLRouting.Route(.case(Blog.Route.View.post)) {
                    Path {
                        OneOf {
                            Parse {
                                Digits()
                                    .map(.case(Either<String, Int>.right))
                                End()
                            }
                            Parse(.string.map(.case(Either<String, Int>.left)))
                        }
                    }
                }

                URLRouting.Route(.case(Blog.Route.View.index))
            }
        }
    }
}
