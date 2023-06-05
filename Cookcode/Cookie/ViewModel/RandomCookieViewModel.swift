//
//  CookieListViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/23.
//

import SwiftUI
import AVFoundation

final class RandomCookieViewModel: ObservableObject {
    
    @Published var cookies: [CookieDetail] = []
    @Published var cookieSelection: String = ""
    @Published var drag: CGFloat = .zero
    @Published var serviceAlert: ServiceAlert = .init()
    
    private let cookieService: CookieServiceProtocol
    
    init(cookieService: CookieServiceProtocol) {
        self.cookieService = cookieService
        
        Task {
            await initCookie()
        }
        
    }
    
    @MainActor
    private func initCookie() async {
        let result = await cookieService.fetchCookie()
        
        switch result {
        case .success(let success):
            guard let dto = success.data.first else { return }
            let cookie1 = CookieDetail(dto: dto)
            let cookie2 = CookieDetail(dto: dto)
            let cookie3 = CookieDetail(dto: dto)
            let cookie4 = CookieDetail(dto: dto)
            let mock = CookieDetail(dto: dto)
            
            cookies.append(cookie1)
            cookies.append(cookie2)
            cookies.append(cookie3)
            cookies.append(cookie4)
            cookies.append(mock)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    
    private func getCookie() async -> CookieDetail? {
        let result = await cookieService.fetchCookie()
        
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
    func rotateTab() {
        guard checkArrayBound() else { return }
        
        if cookieSelection == cookies[0].id && drag < 0 {
            guard let last = cookies.last else { return }
            cookieSelection = last.id
            print("up carousel!")
        }

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
        
        
        let updatedIndex = (currentIndex + 2) % 4
        
        
        guard let newCookie = await getCookie() else { return }
        
        cookies[updatedIndex].update(cookie: newCookie)
        
        if updatedIndex == 0 {
            cookies[cookies.count - 1].update(cookie: newCookie)
        }
    }
    
    private func checkArrayBound() -> Bool {
        let indices = cookies.indices
        return indices.contains(0) && indices.contains(cookies.count - 1)
    }
}
