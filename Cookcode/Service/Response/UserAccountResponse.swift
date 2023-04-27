//
//  UserAccountResponse.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Foundation

struct UserAccountResponse: Codable {
    let message: String
    let status: Int
    let data: Data
    
    // MARK: - DataClass
    struct Data: Codable {
        let userID: Int
        let email, nickname, authority, status: String

        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case email, nickname, authority, status
        }
    }
}


