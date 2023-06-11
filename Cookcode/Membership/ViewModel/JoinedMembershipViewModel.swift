//
//  JoinedMembershipViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

final class JoineMembershipViewModel: JoinedMembershipInteractable {
    
    @Published var memberships: [JoinedMembershipDetail] = .init()
    @Published var serviceAlert: ServiceAlert = .init()
    
    private let membershipService = MembershipService()
    
    init() {
        Task { await fetch() }
    }
    
    func fetch() async {
        let result = await membershipService.fetchMyMemberships()
        switch result {
        case .success(let success):
            memberships = success.data.map { JoinedMembershipDetail(dto: $0) }
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    func joinedMembershipButtonTapped(_ grade: JoinedMembershipDetail) async {
        
    }
}
