//
//  UserDetail.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/21.
//

import Foundation

struct UserDetail {
    let thumbnail: String?
    let nickname: String
    let email: String
}

extension UserDetail {
    init (dto: UserDetailDTO) {
        thumbnail = dto.profileImage
        nickname = dto.nickname
        email = dto.email
    }
}
