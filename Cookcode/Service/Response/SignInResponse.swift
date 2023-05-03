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
    
    static func MOCK() -> Data {
        Data(userID: 1, accessToken: "accessToken", refreshToken: "refreshToken")
    }
    
    struct Data: Codable {
        let userID: Int
        let accessToken, refreshToken: String

        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case accessToken, refreshToken
        }
    }
}

// MARK: - DataClass

