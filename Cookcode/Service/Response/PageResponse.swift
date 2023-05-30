//
//  PageServiceResponse.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/30.
//

import Foundation

struct PageResponse<T: Codable & Mock>: Codable, Mock {
    static func mock() -> PageResponse<T> {
        PageResponse(content: .mock(), numberOfElements: 1, hasNext: false)
    }
    
    let content: [T]
    var numberOfElements: Int
    var hasNext: Bool
}
