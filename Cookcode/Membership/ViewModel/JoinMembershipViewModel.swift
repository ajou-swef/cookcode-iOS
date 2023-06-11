//
//  JoinMembershipViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

final class JoinMembershipViewModel: ObservableObject, MembershipGradeInteractable {
    private let userId: Int
    private let membershipService = MembershipService()
    
    @Published var membershipGrades: [MembershipGradeDetail] = .init()
    @Published var serviceAlert: ServiceAlert = .init()
    
    init(userId: Int) {
        self.userId = userId
        
        Task { await fetchMembershipGrades() }
    }
    
    func membershipGradeButtonTapped(_ grade: MembershipGradeDetail) {
        
    }
    
    @MainActor
    func fetchMembershipGrades() async {
        let result = await membershipService.fetchMembershipGradesById(userId)
        
        switch result {
        case .success(let success):
            membershipGrades = success.data.map { MembershipGradeDetail(dto: $0) }
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
}
