//
//  AccountSignuUpResponse .swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Foundation

struct SignUpResponse: Codable {
    let message: String
    let status: Int
    let data: Data
    
    struct Data: Codable {
        let userID: Int
        let nickname, email: String

        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case nickname, email
        }
    }

}

