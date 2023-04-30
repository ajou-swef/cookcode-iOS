//
//  User.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

struct User: Codable {
    let userID: Int
    let profileImage, nickname: String
    
    static let MOCK_DATA: User = User(userID: 1, profileImage: "https://picsum.photos/200/300/?blur", nickname: "Page")

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case profileImage, nickname
    }
}
