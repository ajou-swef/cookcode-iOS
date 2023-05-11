//
//  User.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

struct UserDTO: Codable, Hashable {
    let userID: Int
    let profileImage: String?
    let nickname: String
    
    static let MOCK_DATA: UserDTO = UserDTO(userID: 1, profileImage: "https://picsum.photos/200/300/?blur", nickname: "Page")

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case profileImage, nickname
    }
}
