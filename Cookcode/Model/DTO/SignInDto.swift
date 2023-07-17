//
//  AccountSignInResponse.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Foundation
import cookcode_service

struct SignInDto: Codable, Mock {
    static func mock() -> SignInDto {
        SignInDto(userID: 1, accessToken: "accessToken", refreshToken: "refreshToken")
    }
    
    let userID: Int
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case accessToken, refreshToken
    }
}

// MARK: - DataClass

