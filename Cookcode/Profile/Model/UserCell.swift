//
//  UserCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import Foundation

struct UserCell: Identifiable, Mock {
    static func mock() -> UserCell {
        UserCell(userName: "유저네임", imageURL: "https://picsum.photos/200/300", subscriberCount: 132, email: "nou0ggid@gmail.com", userId: 7)
    }

    let id: String = UUID().uuidString
    let userName: String
    let imageURL: String?
    let subscriberCount: Int
    let email: String
    let userId: Int
}

extension UserCell {
    init(dto: UserCellDto) {
        userName = dto.nickname
        imageURL = dto.profileImage
        userId = dto.userID
        subscriberCount = 132
        email = "nou0ggid@gmail.com"
    }
}
