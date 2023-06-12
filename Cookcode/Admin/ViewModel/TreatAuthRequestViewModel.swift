//
//  TreatAuthRequestViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/12.
//

import SwiftUI

final class TreatAuthRequestViewModel: UserAuthInteractable {
    @Published var serviceAlert: ViewAlert = .init()
    @Published var userAuth: [UserAuth] = .init()
    private let adminService = AdminService()
    
    init() {
        Task { await fetch() }
    }
    
    func fetch() async {
        let result = await adminService.fetchAuthRequest()
        switch result {
        case .success(let success):
            userAuth = success.data.map { UserAuth(dto: $0) }
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
        }
    }
    
    func userAuthOkButtonTapped(_ userAuth: UserAuth) async {
        let _ = await adminService.treatAuthRequest(userId: userAuth.userID, isAccepted: true)
        await fetch()
    }
    
    func userAuthCancelButtonTapped(_ userAuth: UserAuth) async {
        let _ = await adminService.treatAuthRequest(userId: userAuth.userID, isAccepted: false)
        await fetch()
    }
}
