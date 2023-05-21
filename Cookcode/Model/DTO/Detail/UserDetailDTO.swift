//
//  UserDetailDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/21.
//

import Alamofire

struct UserDetailDTO: Codable, Mock {
    static func mock() -> UserDetailDTO {
        UserDetailDTO(userID: 13, email: "nou0ggid2@gmail.com", nickname: "page", profileImage: nil, status: "VALID", authority: "USER")
    }
    
    let userID: Int
    let email, nickname: String
    let profileImage: String?
    let status, authority: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case email, nickname, profileImage, status, authority
    }
}
