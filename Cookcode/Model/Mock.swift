//
//  Mock.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/02.
//

import Foundation

protocol Mock {
    associatedtype MockType
    
    static func Mock() -> MockType
    static func Mocks(_ count: Int) -> [MockType]
}

extension Mock {
    static func Mocks(_ count: Int) -> [MockType] {
        var mocks: [MockType]
        for _ in 0..<count {
            mocks.append(Mock())
        }
        return mocks
    }
}
