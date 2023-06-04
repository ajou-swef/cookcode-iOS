//
//  User.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

struct UserCellDto: Decodable, Hashable, Mock {
    static func mock() -> UserCellDto {
        UserCellDto(userID: 1, profileImage: "https://picsum.photos/200/300/?blur", nickname: "닉네임")
    }

    let userID: Int
    let profileImage: String?
    let nickname: String

    static let MOCK_DATA: UserCellDto = UserCellDto(userID: 1, profileImage: "https://picsum.photos/200/300/?blur", nickname: "Page")

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case profileImage, nickname
    }
}
