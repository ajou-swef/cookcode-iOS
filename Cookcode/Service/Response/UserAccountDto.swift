//
//  UserAccountResponse.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Foundation
import cookcode_service

struct UserAccountDto: Codable, Mock {
    static func mock() -> UserAccountDto {
        UserAccountDto(userID: 123, email: "nou0jid@ajou.ac.kr", nickname: "page", authority: "USER", status: "VALID")
    }
    
    let userID: Int
    let email, nickname, authority, status: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case email, nickname, authority, status
    }
}
