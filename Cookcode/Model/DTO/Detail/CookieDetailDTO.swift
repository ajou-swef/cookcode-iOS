//
//  CookieDetailDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/25.
//

import Foundation

struct CookieDetailDTO: Codable, Mock {
    static func mock() -> CookieDetailDTO {
        CookieDetailDTO(id: 0, title: "쿠키제목", desc: "쿠키 설명",
                        videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
    }
    
    let id: Int
    let title, desc: String
    let videoURL: String

    enum CodingKeys: String, CodingKey {
        case id, title, desc
        case videoURL = "videoUrl"
    }
}
