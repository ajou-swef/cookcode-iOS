//
//  UserProfileCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import Foundation
import cookcode_service

struct UserProfileCell: Identifiable, Mock {
    static func mock() -> UserProfileCell {
        UserProfileCell(dto: .mock())
    }

    let id: String = UUID().uuidString
    let userName: String
    let imageURL: String?
    let subscriberCount: Int
    let email: String
    let userId: Int
}

extension UserProfileCell {
    init (dto: UserProfileCellDto) {
        userName = dto.nickname
        imageURL = dto.profileImage
        userId = dto.userID
        subscriberCount = dto.subscriberCount
        email = dto.email
    }
}
