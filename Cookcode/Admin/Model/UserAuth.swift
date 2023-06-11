//
//  UserAuth.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import Foundation

struct UserAuth: Identifiable, Mock {
    static func mock() -> UserAuth {
        UserAuth(dto: .mock())
    }
    
    let id: String = UUID().uuidString
    let userID: Int
    let authority: Authority
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case authority, createdAt
    }
}

extension UserAuth {
    init (dto: UserAutoDto) {
        userID = dto.userID
        authority = dto.authority
        createdAt = dto.createdAt
    }
}
