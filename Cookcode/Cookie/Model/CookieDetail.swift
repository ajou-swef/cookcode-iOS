//
//  CookieDetail.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import Foundation


struct CookieDetail: Identifiable {
    let id: String = UUID().uuidString
    
    var url: String
    var title: String
    var cookieId: Int
    var description: String
    var likesCount: Int
    var commentsCount: Int
    
    var didLikes: Bool = false
    
    mutating func update(cookie: CookieDetail) {
        url = cookie.url
        title = cookie.title
        cookieId = cookie.cookieId
        description = cookie.description
    }
    
    static func mock() -> CookieDetail {
        CookieDetail(dto: .mock())
    }
}

extension CookieDetail {
    init(dto: CookieDetailDTO) {
        url = dto.videoURL
        title = dto.title
        cookieId = dto.id
        description = dto.desc
        likesCount = 125
        commentsCount = 592
        didLikes = false
    }
}
