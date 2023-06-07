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
    let userId: Int
    
    var subscribeButtonIsPresented: Bool {
        userDetail.notSubscribed
    }
    
    var unsubscribeButtonIsPresented: Bool {
        userDetail.subscribed
    }
    
    init(accoutnService: AccountServiceProtocol, userId: Int) {
        self.userId = userId
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
        
        userDetail.isSubscribed = true
        let result = await accountService.toggleUserSubscribeById(userDetail.userId)
        
        switch result {
        case .success(_):
            print("구독 성공")
        case .failure(let failure):
            print("구독 실패")
            serviceAlert.presentAlert(failure)
        }
    }
    
    @MainActor
    func unsubscribeButtonTapped() async {
        guard userDetail.isNotMyProfile else { return }
        
        userDetail.isSubscribed = false
        let result = await accountService.toggleUserSubscribeById(userDetail.userId)
        
        switch result {
        case .success(_):
            print("구독취소 성공")
        case .failure(let failure):
            print("구독취소 실패")
            serviceAlert.presentAlert(failure)
        }
    }
    
    @MainActor
    private func fetchUserDetail() async {
        let result = await accountService.getUserDetailById(userId)
        
        switch result {
        case .success(let success):
            userDetail = UserDetail(dto: success.data)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
}
