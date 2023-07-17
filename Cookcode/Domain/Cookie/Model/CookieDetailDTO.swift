//
//  CookieDetailDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/25.
//

import Foundation
import cookcode_service

struct CookieDetailDTO: Decodable, Mock {
    static func mock() -> CookieDetailDTO {
        CookieDetailDTO(cookieID: 1, title: "쿠키제목", desc: "쿠키 설명", thumbnailURL: "https://picsum.photos/200/300", videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", recipeID: nil, createdAt: "2020-01-01", user: .mock(), isLiked: false, likeCount: 10, commentCount: 10)
    }
    
    let cookieID: Int
    let title, desc: String
    let thumbnailURL, videoURL: String
    let recipeID: Int?
    let createdAt: String
    let user: UserCellDTO
    let isLiked: Bool
    let likeCount, commentCount: Int

    enum CodingKeys: String, CodingKey {
        case cookieID = "cookieId"
        case title, desc
        case thumbnailURL = "thumbnailUrl"
        case videoURL = "videoUrl"
        case recipeID = "recipeId"
        case createdAt, user, isLiked, likeCount, commentCount
    }
}



