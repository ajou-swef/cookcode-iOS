//
//  JoinedMembershipDetailDto.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import Foundation

struct JoinedMembershipDetailDto: Decodable, Mock {
    static func mock() -> JoinedMembershipDetailDto {
        JoinedMembershipDetailDto(membershipID: 1, grade: "그레이드", price: 8900, creater: .mock())
    }
    
    
    let membershipID: Int
    let grade: String
    let price: Int
    let creater: UserCellDto

    enum CodingKeys: String, CodingKey {
        case membershipID = "membershipId"
        case grade, price, creater
    }
}
