//
//  MySubscriberViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/07.
//

import Foundation

final class MySubscriberViewModel: UserFetcher {
    
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var pageState: PageState = .wait(0)
    @Published var fetchTriggerOffset: CGFloat = .zero
    @Published var contents: [UserProfileCell] = []
    
    internal let pageSize: Int = 10
    internal let accountService: AccountServiceProtocol
    
    init(accountSerivce: AccountServiceProtocol) {
        self.accountService = accountSerivce
        
        Task { await onFetch() }
    }
    
    @MainActor
    func onFetch() async {
        let curPage = pageState.page
        pageState = .loading(curPage)
        
        let result = await accountService.fetchMySubscriber()
        
        switch result {
        case .success(let success):
            appendCell(success)
            controllPageState(success, curPage)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
            pageState = .noRemain
        }
    }
    
    @MainActor
    func appendCell(_ success: ServiceResponse<PageResponse<UserProfileCellDto>>) {
        let newCells = success.data.content.map { UserProfileCell(dto: $0) }
        contents.append(contentsOf: newCells)
    }
    
    
}
