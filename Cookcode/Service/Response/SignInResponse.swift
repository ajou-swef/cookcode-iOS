//
//  AccountSignInResponse.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Foundation

struct SignInResponse: Codable {
    let message: String
    let status: Int
    let data: Data
    
    static let MOCK_DATA: Data = Data(userID: 123, nickname: "page", email: "nou0jid@ajou.ac.kr")
    
    struct Data: Codable {
        let userID: Int
        let nickname, email: String

        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case nickname, email
        }
    }
}

// MARK: - DataClass

