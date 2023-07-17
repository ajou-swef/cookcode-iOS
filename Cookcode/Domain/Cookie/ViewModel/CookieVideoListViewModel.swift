//
//  CookieVideoListViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/05.
//

import cookcode_service
import SwiftUI

final class CookieVideoListViewModel: ObservableObject, PresentCommentSheet, likeButtonInteractable, CookieInteractable {
    
    @Published var selectedCookie: CookieDetail?
    @Published var commentSheetIsPresent: Bool = false
    @Published var cookies: [CookieDetail]
    @Published var cookieSelection: String = ""
    @Published var serviceAlert: ViewAlert = .init()
    
    
    var cookieService: CookieService = .init()
    var commentService: CommentServiceProtocol = CookieService()
    
    
    init(cookies: [CookieDetail], selectedCookieId: Int) {
        self.cookies = cookies
        guard let firstCookie = cookies.first(where: { $0.contentId == selectedCookieId }) else { return }
        cookieSelection = firstCookie.id
        
        Task {
            await avControll(cookieSelection)
        }
        
    }
    
    func cookieInteractButtonTapped(_ cookkie: CookieDetail) {
        selectedCookie = cookkie
    }
    
    @MainActor
    func avControll(_ selection: String) {
        for (index, cookie) in cookies.enumerated() {
            if cookie.id == selection {
                cookies[index].onAppear()
            } else {
                cookies[index].onDisapper()
            }
        }
    }
    
    func likeButtonTapped(_ uuid: String) async {
        guard let index = cookies.firstIndex(where: { $0.id == uuid }) else { return }
        cookies[index].likeInteract()
        
        let _ = await cookieService.likesCookie(cookies[index])
    }
    
    func updateCookie(_ updateInfo: [CellType: CellUpdateInfo]) {
        guard let info = updateInfo[.cookie] else { return }
        
        switch info.updateType {
        case .delete:
            Task { await removeCookie(id:info.cellId) }
        case .patch:
            Task { await patchCookie(id: info.cellId) }
        }
    }
    
    
    
    @MainActor
    private func removeCookie(id: Int) async {
        guard let index = cookies.firstIndex(where: { $0.contentId == id }) else { return }
        cookies.remove(at: index)
    }
    
    @MainActor
    private func patchCookie(id: Int) async {
        guard let index = cookies.firstIndex(where: { $0.contentId == id }) else { return }
        let result = await cookieService.getCookieByCookieId(id)
        
        switch result {
        case .success(let success):
            let cookie = CookieDetail(dto: success.data)
            cookies[index].update(cookie: cookie)
            avControll(cookieSelection)
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
        }
    }
}
