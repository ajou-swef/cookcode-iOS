//
//  UserProfileCellDto.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import Foundation

struct UserProfileCellDto: Decodable, Mock {
    static func mock() -> UserProfileCellDto {
        UserProfileCellDto(userID: 1, email: "email@gmail.com", nickname: "닉네임", profileImage: "https://picsum.photos/200/300", status: "status", authority: "authority", subscriberCount: 132)
    }
    
    let userID: Int
    let email, nickname: String
    let profileImage: String?
    let status, authority: String
    let subscriberCount: Int

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case email, nickname, profileImage, status, authority
        case subscriberCount
    }
}
