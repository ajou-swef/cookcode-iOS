//
//  UserAuthDto.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import Foundation

struct UserAutoDto: Decodable {
    let userID: Int
    let createdAt: String
    let authority: Authority

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case authority, createdAt
    }
}
