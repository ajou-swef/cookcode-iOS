//
//  MembershipGradeDto.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import Foundation

struct MembershipGradeFormDto: Encodable {
    let grade: String
    let price: Int
}

extension MembershipGradeFormDto {
    init (membershipGrade: MembershipGradeForm) {
        grade = membershipGrade.grade
        price = Int(membershipGrade.price) ?? 99999999
    }
}
