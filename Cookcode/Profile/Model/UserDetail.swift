//
//  UserDetail.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/21.
//

import Foundation
import _PhotosUI_SwiftUI

struct UserDetail: Mock {
    static func mock() -> UserDetail {
        UserDetail(userId: -1, thumbnail: "", nickname: "", email: "", isMyProfile: false, isSubscribed: false, authority: .user)
    }
    
    let userId: Int
    let thumbnail: String?
    let nickname: String
    let email: String
    let isMyProfile: Bool
    var isSubscribed: Bool
    var authority: Authority
    
    var isNotMyProfile: Bool {
        !isMyProfile
    }
    
    var notSubscribed: Bool {
        isNotMyProfile && !isSubscribed
    }
    
    var subscribed: Bool {
        isNotMyProfile && isSubscribed
    }
}

extension UserDetail {
    init (dto: UserDetailDTO) {
        thumbnail = dto.profileImage
        nickname = dto.nickname
        email = dto.email
        let myId = UserDefaults.standard.integer(forKey: USER_ID)
        userId = dto.userID
        isMyProfile = (myId == dto.userID)
        isSubscribed = dto.isSubscribed
        authority = dto.authority
    }
}
