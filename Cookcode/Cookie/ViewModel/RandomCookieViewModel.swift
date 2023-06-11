//
//  CookieListViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/23.
//

import SwiftUI
import AVFoundation

final class RandomCookieViewModel: ObservableObject, likeButtonInteractable, PresentCommentSheet, CookieInteractable {

    @Published var cookies: [CookieDetail] = []
    @Published var cookieSelection: String = ""
    @Published var drag: CGFloat = .zero
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var commentSheetIsPresent: Bool = false
    @Published var selectedDetail: CookieDetail?
    @Published var selectedCookie: CookieDetail?
    
    private let cookieService: CookieServiceProtocol
    var commentService: CommentServiceProtocol
    
    init(cookieService: CookieServiceProtocol) {
        self.cookieService = cookieService
        commentService = cookieService
        
        Task {
            await initCookie()
        }
        
    }
    
    @MainActor
    private func initCookie() async {
        let result = await cookieService.getCookie()
        
        switch result {
        case .success(let success):
            guard let dto = success.data.first else { return }
            
            let cookie1 = CookieDetail(dto: dto)
            let cookie2 = CookieDetail(dto: dto)
            let cookie3 = CookieDetail(dto: dto)
            let cookie4 = CookieDetail(dto: dto)
            let mock = CookieDetail(dto: dto)
            cookieSelection = cookie1.id
            
            cookies.append(cookie1)
            cookies.append(cookie2)
            cookies.append(cookie3)
            cookies.append(cookie4)
            cookies.append(mock)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    @MainActor
    private func getCookie() async -> CookieDetail? {
        let result = await cookieService.getCookie()
        
        switch result {
        case .success(let success):
            guard let dto = success.data.first else { return nil }
            return CookieDetail(dto: dto)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
            return nil
        }
    }
    
    @MainActor
    func cookieInteractButtonTapped(_ cookkie: CookieDetail) {
        self.selectedCookie = cookkie
    }
    
    fileprivate func extractedFunc() {
        if cookieSelection == cookies[0].id && drag < 0 {
            guard let last = cookies.last else { return }
            cookieSelection = last.id
            print("up carousel!")
        }
    }
    
    @MainActor
    func rotateTab() {
        guard checkArrayBound() else { return }
        
        extractedFunc()

        if cookieSelection == cookies[cookies.count - 1].id && drag > 0 {
            cookieSelection = cookies[0].id
        }
    }
    
    @MainActor
    func loadNewCookie() async {
        guard let currentIndex = cookies.firstIndex(where: { $0.id == cookieSelection }) else {
            return
        }
        
        guard checkArrayBound() else { return }
        
        avControll(cookieSelection)
        let updatedIndex = (currentIndex + 2) % 4
        
        
        guard let newCookie = await getCookie() else { return }
        
        cookies[updatedIndex].update(cookie: newCookie)
        
        if updatedIndex == 0 {
            cookies[cookies.count - 1].update(cookie: newCookie)
        }
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
    
    private func checkArrayBound() -> Bool {
        let indices = cookies.indices
        return indices.contains(0) && indices.contains(cookies.count - 1)
    }
    
    @MainActor
    func likeButtonTapped(_ uuid: String) async {
        guard let index = cookies.firstIndex(where: { $0.id == uuid }) else { return }
        cookies[index].likeInteract()
        
        let _ = await cookieService.likesCookie(cookies[index])
    }
    
    func updateCookie(_ updateInfo: [CellType: CellUpdateInfo]) {
        guard let info = updateInfo[.cookie] else { return }
        
        switch info.updateType {
        case .delete:
            Task { await changeCookie(id:info.cellId) }
        case .patch:
            Task { await patchCookie(id: info.cellId) }
        }
    }
    
    
    @MainActor
    private func changeCookie(id: Int) async {
        guard let index = cookies.firstIndex(where: { $0.contentId == id }) else { return }
        let result = await cookieService.getCookie()
        
        switch result {
        case .success(let success):
            if let first = success.data.first {
                let cookie = CookieDetail(dto: first)
                cookies[index].update(cookie: cookie)
                
                if index == 0 {
                    cookies[cookies.count - 1].update(cookie: cookie)
                }
                
                avControll(cookieSelection)
            }
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    @MainActor
    private func patchCookie(id: Int) async {
        guard let index = cookies.firstIndex(where: { $0.contentId == id }) else { return }
        let result = await cookieService.getCookieByCookieId(id)
        
        switch result {
        case .success(let success):
            let cookie = CookieDetail(dto: success.data)
            cookies[index].update(cookie: cookie)
            
            if index == 0 {
                cookies[cookies.count - 1].update(cookie: cookie)
            }
            
            avControll(cookieSelection)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
}
