//
//  MembershipGradeInteractable.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

protocol MembershipGradeInteractable: ObservableObject {
    func membershipGradeButtonTapped(_ grade: MembershipGradeDetail) async
}
