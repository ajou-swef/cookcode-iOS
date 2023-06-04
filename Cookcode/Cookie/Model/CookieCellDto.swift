//
//  CookieCellDto.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import Foundation

struct CookieCellDto: Mock, Decodable {
    static func mock() -> CookieCellDto {
        CookieCellDto(cookieId: 1)
    }
    
    let cookieId: Int
}
