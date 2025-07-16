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
        htmlDocument: @escaping (() -> any HTML) -> any AsyncResponseEncodable
    ) async throws -> any AsyncResponseEncodable {
        switch route {
        case .view(let view):
            let response = try await Blog.Route.View.response(
                route: view
            )
            return htmlDocument {
               response
            }
        }
    }
}
