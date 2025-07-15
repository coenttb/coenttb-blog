//
//  File.swift
//  coenttb-blog
//
//  Created by Coen ten Thije Boonkkamp on 03/07/2025.
//

import Foundation

let filenameToResourceUrl: @Sendable (
    String
) -> URL? = {
    Bundle.module.url(
        forResource: $0,
        withExtension: "md"
    )
}
