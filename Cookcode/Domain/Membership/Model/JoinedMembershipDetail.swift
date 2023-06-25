//
//  JoinedMembershipDetail.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import Foundation

struct JoinedMembershipDetail: Identifiable, Mock {
    static func mock() -> JoinedMembershipDetail {
        JoinedMembershipDetail(dto: .mock())
    }
    
    let id: String = UUID().uuidString
    let membershipID: Int
    let grade: String
    let price: Int
    let creater: UserCell

    enum CodingKeys: String, CodingKey {
        case membershipID = "membershipId"
        case grade, price, creater
    }
}

extension JoinedMembershipDetail {
    init (dto: JoinedMembershipDetailDto) {
        membershipID = dto.membershipID
        grade = dto.grade
        price = dto.price
        creater = UserCell(dto: dto.creater)
    }
}
