//
//  ProfileViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/02.
//

import SwiftUI

final class ProfileViewModel: ObservableObject, SearchTypeSelectable {
    
    @Published private(set) var userDetail: UserDetail = .mock()
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var seachType: SearchType = .recipe
    
    private let accountService: AccountServiceProtocol
    
    init(accoutnService: AccountServiceProtocol) {
        self.accountService = accoutnService
        
        Task {
            await fetchUserDetail() 
        }
    }
    
    func searchTypeTapped(_ searchType: SearchType) {
        self.seachType = searchType
    }
    
    @MainActor 
    func subscribeButtonTapped() async {
        guard userDetail.isNotMyProfile else { return }
        
        let result = await accountService.subscribeUserById(userDetail.userId)
        
        switch result {
        case .success(let success):
            break
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    @MainActor
    private func fetchUserDetail() async {
        let myId = UserDefaults.standard.integer(forKey: USER_ID)
        
        let result = await accountService.getUserDetailById(myId)
        
        switch result {
        case .success(let success):
            userDetail = UserDetail(dto: success.data)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
}
