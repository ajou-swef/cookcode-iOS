//
//  JoinedMembershipGradeInteractable.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

protocol JoinedMembershipInteractable: ObservableObject {
    func joinedMembershipButtonTapped(_ grade: JoinedMembershipDetail) async
}
