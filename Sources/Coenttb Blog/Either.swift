//
//  File.swift
//  coenttb-blog
//
//  Created by Coen ten Thije Boonkkamp on 15/07/2025.
//

@preconcurrency import Either
import Foundation

extension Either: @retroactive Hashable where L: Hashable, R: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .left(let l):
            hasher.combine(0)
            hasher.combine(l)
        case .right(let r):
            hasher.combine(1)
            hasher.combine(r)
        }
    }
}
