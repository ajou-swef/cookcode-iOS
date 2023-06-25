//
//  CookieUserViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import SwiftUI

final class CookieUserViewModel: CookieFetcher {
    typealias Dto = CookieDetailDTO
    typealias T = CookieDetail
    
    @Published var serviceAlert: ViewAlert = .init()
    @Published var pageState: PageState = .wait(0)
    @Published var fetchTriggerOffset: CGFloat = .zero
    @Published var contents: [CookieDetail] = .init()
    
    private let userId: Int
    internal let pageSize: Int = 10
    internal let cookieService: CookieServiceProtocol
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init (cookieService: CookieServiceProtocol, userId: Int) {
        self.cookieService = CookieServiceInjector.select(service: cookieService)
        self.userId = userId
    }
    
    @MainActor
    func refresh() async {
        contents.removeAll()
        await onFetch()
    }
    
    
    @MainActor
    func onFetch() async {
        let curPage = pageState.page
        pageState = .loading(curPage)
        
        let result = await cookieService.getCookieCellByUserId(userId, page: curPage)
        
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
    func appendCell(_ success: ServiceResponse<PageResponse<CookieDetailDTO>>) {
        let newCells = success.data.content.map { CookieDetail(dto: $0) }
        contents.append(contentsOf: newCells)
    }
}
