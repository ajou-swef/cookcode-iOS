//
//  VideoResponse.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Foundation

struct VideoResponse: Codable {
    let message: String
    let status: Int
    let data: VideoDataURL
}

// MARK: - DataClass
struct VideoDataURL: Codable {
    let photoURL: [String]
    
    static func MOCK_DATA() -> VideoDataURL {
        VideoDataURL(photoURL: ["http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"])
    }
    enum CodingKeys: String, CodingKey {
        case photoURL = "photoUrl"
    }
}
