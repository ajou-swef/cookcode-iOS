//
//  AccountSignuUpResponse .swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Foundation


struct SignUpDto: Codable, Mock  {
    static func mock() -> SignUpDto {
        SignUpDto(userID: 1, name: "page", email: "nou0jid@ajou.ac.kr")
    }
    
    let userID: Int
    let name, email: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case name, email
    }
}
