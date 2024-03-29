//
//  Mock.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/02.
//

import Foundation

protocol Mock {
    static func mock() -> Self
    static func mocks(_ count: Int) -> [Self]
}

extension Mock {
    static func mocks(_ count: Int) -> [Self] {
        var mocks: [Self] = []
        for _ in 0..<count {
            mocks.append(mock())
        }
        return mocks
    }
}
