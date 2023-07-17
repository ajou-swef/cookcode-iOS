//
//  MembershipGradeDetailDto.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import Foundation
import cookcode_service

struct MembershipGradeDetailDto: Decodable, Mock {
    static func mock() -> MembershipGradeDetailDto {
        MembershipGradeDetailDto(membershipID: 1, grade: "그레이드", price: 100000)
    }
    
    
    let membershipID: Int
    let grade: String
    let price: Int

    enum CodingKeys: String, CodingKey {
        case membershipID = "membershipId"
        case grade, price
    }
}
