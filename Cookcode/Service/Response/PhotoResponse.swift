//
//  PhotoResponse.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Foundation

struct PhotoResponse: Codable {
    let message: String
    let status: Int
    let data: PhotoURL
}

// MARK: - DataClass
struct PhotoURL: Codable {
    let photoURL: [String]
    
    static func MOCK_DATA() -> PhotoURL {
        PhotoURL(photoURL: ["https://picsum.photos/200"])
    }

    enum CodingKeys: String, CodingKey {
        case photoURL = "photoUrl"
    }
}
