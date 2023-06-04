//
//  UserSearchViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import SwiftUI

final class UserSearchViewModel: Pagenable, Refreshable, Searchable {
    
    typealias Dto = UserProfileCellDto
    typealias T = UserProfileCell
    
    @Published var pageState: PageState = .wait(0)
    @Published var fetchTriggerOffset: CGFloat = .zero
    @Published var dragVelocity: CGFloat = .zero
    @Published var scrollOffset: CGFloat = .zero
    @Published var contents: [UserProfileCell] = []
    @Published var serviceAlert: ServiceAlert = .init()
    
    private let accountService: AccountServiceProtocol
    internal let query: String
    internal let spaceName: String = "userSearchViewModel"
    internal let pageSize: Int = 10
    internal let refreshThreshold: CGFloat = 40
    
    
    init (accountService: AccountServiceProtocol, query: String) {
        self.accountService = accountService
        self.query = query
        
        Task { await onFetch() }
    }
    
    
    @MainActor
    func onRefresh() async {
        pageState = .wait(0)
        contents.removeAll()
        await onFetch()
    }
    
    @MainActor
    func onFetch() async {
        let curPage = pageState.page
        pageState = .loading(curPage)
        print("page(\(curPage)) loading start")
        
        let result = await accountService.searchUser(query: query)
        
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
