//
//  UserCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import Foundation

struct UserCell: Identifiable, Mock {
    static func mock() -> UserCell {
        UserCell(userName: "유저네임", imageURL: "https://picsum.photos/200/300",
                 email: "nou0ggid@gmail.com", userId: 7)
    }

    let id: String = UUID().uuidString
    let userName: String
    let imageURL: String?
    let email: String
    let userId: Int
}

extension UserCell {
    init(dto: UserCellDto) {
        userName = dto.nickname
        imageURL = dto.profileImage
        userId = dto.userID
        email = "nou0ggid@gmail.com"
    }
}
