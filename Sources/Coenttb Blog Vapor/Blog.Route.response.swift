//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 16/12/2024.
//

import Coenttb_Blog
import Coenttb_Vapor
import Coenttb_Web

extension Blog.Route {
    public static func response(
        route: Blog.Route,
        blurb: TranslatedString,
        companyXComHandle: String?,
        getCurrentUser: () -> (newsletterSubscribed: Bool, accessToBlog: Bool)?,
        coenttbWebNewsletter: (() -> any HTML)?,
        defaultDocument: @escaping (() -> any HTML) -> any AsyncResponseEncodable,
        posts: [Blog.Post]
    ) async throws -> any AsyncResponseEncodable {
        switch route {
        case .view(let view):
            try await Blog.Route.View.response(
                route: view,
                blurb: blurb,
                companyXComHandle: companyXComHandle,
                getCurrentUser: getCurrentUser,
                coenttbWebNewsletter: coenttbWebNewsletter,
                defaultDocument: defaultDocument,
                posts: posts
            )
        }
    }
}
