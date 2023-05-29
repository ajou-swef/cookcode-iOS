//
//  CookieDetailDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/25.
//

import Foundation

struct CookieDetailDTO: Codable, Mock {
    static func mock() -> CookieDetailDTO {
        CookieDetailDTO(id: 1, title: "쿠키제목", desc: "쿠키 설명", videoURL: "", recipeID: nil, createdAt: "2020-01-01", user: .MOCK_DATA, isLiked: 0, likeCount: 10, commentCount: 10)
    }
    
    let id: Int
    let title, desc: String
    let videoURL: String
    let recipeID: Int?
    let createdAt: String
    let user: UserDTO
    let isLiked, likeCount, commentCount: Int

    enum CodingKeys: String, CodingKey {
        case id, title, desc
        case videoURL = "videoUrl"
        case recipeID = "recipeId"
        case createdAt, user, isLiked, likeCount, commentCount
    }
}



