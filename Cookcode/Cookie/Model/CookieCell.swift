//
//  CookieCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/23.
//

import Foundation

struct CookieCell: Identifiable, Mock {
    let id: String = UUID().uuidString
    var thumbnail: String
    var cookieId: Int
    
    static func mock() -> CookieCell {
        CookieCell(thumbnail: "https://picsum.photos/200/300", cookieId: Int.random(in: 0..<1000))
    }
}

extension CookieCell {
    init (dto: CookieCellDto) {
        thumbnail = dto.thumbnailURL
        cookieId = dto.cookieID
    }
}
