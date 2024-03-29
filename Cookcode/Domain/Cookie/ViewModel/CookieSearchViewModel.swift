//
//  CookieSearchViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/05.
//

import SwiftUI

final class CookieSearchViewModel: CookieFetcher, Searchable, Refreshable {
    typealias Dto = CookieDetailDTO
    typealias T = CookieDetail
    
    @Published var serviceAlert: ViewAlert = .init()
    @Published var pageState: PageState = .wait(0)
    @Published var fetchTriggerOffset: CGFloat = .zero
    @Published var contents: [CookieDetail] = .init()
    @Published var dragVelocity: CGFloat = .zero
    
    @Published var scrollOffset: CGFloat = .zero
    
    internal let pageSize: Int = 10
    internal let cookieService: CookieServiceProtocol
    internal let query: String
    internal let spaceName: String = "cookieSearchViewModel"
    internal let refreshThreshold: CGFloat = 40
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init(cookieService: CookieServiceProtocol, query: String) {
        self.cookieService = cookieService
        self.query = query
        
        Task { await onFetch() }
    }
    
    @MainActor
    func appendCell(_ success: ServiceResponse<PageResponse<CookieDetailDTO>>) {
        let newCells = success.data.content.map { CookieDetail(dto: $0) }
        contents.append(contentsOf: newCells)
    }
    
    @MainActor
    func onFetch() async {
        let curPage = pageState.page
        pageState = .loading(curPage)
        
        let result = await cookieService.getCookieCellsByQuery(query, page: curPage)
        
        switch result {
        case .success(let success):
            appendCell(success)
            controllPageState(success, curPage)
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
            pageState = .noRemain
        }
    }
    
    @MainActor
    func onRefresh() async {
        pageState = .wait(0)
        contents.removeAll()
        await onFetch()
    }
}
