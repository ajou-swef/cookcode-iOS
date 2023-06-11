//
//  MembershipGradeDetail.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

struct MembershipGradeDetail: Identifiable {
    let id: String = UUID().uuidString
    let membershipID: Int
    let grade: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case membershipID = "membershipId"
        case grade, price
    }
}
