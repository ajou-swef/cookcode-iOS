//
//  CookieCellDto.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import Foundation

struct CookieCellDto: Decodable, Mock {
    static func mock() -> CookieCellDto {
        CookieCellDto(cookieID: 1, title: "쿠키제목", desc: "쿠키설명",
                      thumbnailURL: "https://picsum.photos/200/300",
                      videoURL: "", recipeID: nil, createdAt: "2023-01-01",
                      user: .mock(), isLiked: 1, likeCount: 13, commentCount: 13)
    }
    
    let cookieID: Int
    let title, desc: String
    let thumbnailURL, videoURL: String
    let recipeID: Int?
    let createdAt: String
    let user: UserCellDto
    let isLiked, likeCount, commentCount: Int

    enum CodingKeys: String, CodingKey {
        case cookieID = "cookieId"
        case title, desc
        case thumbnailURL = "thumbnailUrl"
        case videoURL = "videoUrl"
        case recipeID = "recipeId"
        case createdAt, user, isLiked, likeCount, commentCount
    }
}
