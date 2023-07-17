//
//  UserDetailDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/21.
//

import Alamofire
import cookcode_service

struct UserDetailDTO: Codable, Mock {
    static func mock() -> UserDetailDTO {
        UserDetailDTO(userID: 13, email: "nou0ggid2@gmail.com", nickname: "page", profileImage: "https://picsum.photos/200/300", status: "VALID", authority: .influencer, isSubscribed: false)
    }
    
    let userID: Int
    let email, nickname: String
    let profileImage: String?
    let status: String
    let authority: Authority
    let isSubscribed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case email, nickname, profileImage, status, authority
        case isSubscribed
    }
}
