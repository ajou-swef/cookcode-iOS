//
//  Array + Mock.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import Foundation


extension Array: Mock where Element: Mock {
    static func mock() -> Array<Element> {
        Element.mocks(5)
    }
}
