//
//  UserAuthDto.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import Foundation
import cookcode_service

struct UserAutoDto: Decodable, Mock {
    static func mock() -> UserAutoDto {
        UserAutoDto(userID: 1, createdAt: "2023-01-01", authority: .admin)
    }
    
    let userID: Int
    let createdAt: String
    let authority: Authority

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case authority, createdAt
    }
}
