//
//  CookieUserViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import SwiftUI

final class CookieUserViewModel: CookieFetcher {
    typealias Dto = CookieCellDto
    typealias T = CookieCell
    
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var pageState: PageState = .wait(0)
    @Published var fetchTriggerOffset: CGFloat = .zero
    @Published var contents: [CookieCell] = .init()
    
    private let userId: Int
    internal let pageSize: Int = 10
    internal let cookieService: CookieServiceProtocol
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init (cookieService: CookieServiceProtocol, userId: Int) {
        self.cookieService = cookieService
        self.userId = userId
        
        Task { await onFetch() }
    }
    
    
    @MainActor
    func onFetch() async {
        let curPage = pageState.page
        pageState = .loading(curPage)
        print("page(\(curPage)) loading start")
        
        let result = await cookieService.fetchCookieCellByUserId(userId)
        
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
    func appendCell(_ success: ServiceResponse<PageResponse<CookieCellDto>>) {
        let newCells = success.data.content.map { CookieCell(dto: $0) }
        contents.append(contentsOf: newCells)
    }
}
