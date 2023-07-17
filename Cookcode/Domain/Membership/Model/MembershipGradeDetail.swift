//
//  MembershipGradeDetail.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI
import cookcode_service

struct MembershipGradeDetail: Identifiable, Mock {
    static func mock() -> MembershipGradeDetail {
        MembershipGradeDetail(dto: .mock())
    }
    
    let id: String = UUID().uuidString
    let membershipID: Int
    let grade: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case membershipID = "membershipId"
        case grade, price
    }
}

extension MembershipGradeDetail {
    init (dto: MembershipGradeDetailDto) {
        membershipID = dto.membershipID
        grade = dto.grade
        price = dto.price
    }
}
