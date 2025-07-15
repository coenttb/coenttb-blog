//
//  File.swift
//  
//
//  Created by Coen ten Thije Boonkkamp on 06/07/2023.
//

import Coenttb_Web
@preconcurrency import Either

extension Blog {
    public enum Route: Codable, Hashable, Sendable {
        case index
        case post(Either<String, Int>)
    }
}

extension Blog.Route {
    public static func post(slug: String) -> Blog.Route { .post(.left(slug)) }
    public static func post(_ slug: String) -> Blog.Route { .post(.left(slug)) }
    public static func post(id: Int) -> Blog.Route { .post(.right(id)) }
    public static func post(_ id: Int) -> Blog.Route { .post(.right(id)) }
    public static func post(_ post: Blog.Post) -> Blog.Route { .post(slug: post.slug) }
}

extension Blog.Route {
    public struct Router: ParserPrinter {

        public init() {}

        public var body: some URLRouting.Router<Blog.Route> {
            OneOf {

                URLRouting.Route(.case(Blog.Route.post)) {
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

                URLRouting.Route(.case(Blog.Route.index))
            }
        }
    }
}
