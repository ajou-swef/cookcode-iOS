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
    
    static let MOCK_DATA: Data = Data(userID: 123, name: "Page", email: "nou0jid@ajou.ac.kr")
    
    struct Data: Codable {
        let userID: Int
        let name, email: String

        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case name, email
        }
    }

}

