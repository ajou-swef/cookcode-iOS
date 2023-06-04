//
//  CookieDetailResponseDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/25.
//

import Foundation

struct CookieDetailResponseDTO: Decodable, Mock {
    static func mock() -> CookieDetailResponseDTO {
        CookieDetailResponseDTO(content: CookieDetailDTO.mocks(3),
                                numberOfElements: 0, hasNext: false)
    }
    
    let content: [CookieDetailDTO]
    let numberOfElements: Int
    let hasNext: Bool
}
