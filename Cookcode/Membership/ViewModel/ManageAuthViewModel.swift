//
//  ManageAuthViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

final class MembershipFormViewModel: PatchViewModel{
    
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var useTrashButton: Bool = false
    @Published var deleteAlertIsPresented: Bool = false
    @Published var membershipGrade: MembershipGradeForm = .init()
    
    private let membershipService = MembershipService()
    
    @MainActor
    func mainButtonTapped(dismissAction: DismissAction) async {
        let dto = MembershipGradeFormDto(membershipGrade: membershipGrade)
        let result = await membershipService.createMembership(dto: dto)
        
        switch result {
        case .success(_):
            dismissAction()
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    func deleteOkButtonTapped(dismissAction: DismissAction) async {
        
    }
}
