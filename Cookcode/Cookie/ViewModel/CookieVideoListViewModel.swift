//
//  CookieVideoListViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/05.
//

import SwiftUI

final class CookieVideoListViewModel: ObservableObject, PresentCommentSheet, likeButtonInteractable, CookieInteractable {
    
    @Published var selectedCookie: CookieDetail?
    @Published var commentSheetIsPresent: Bool = false
    @Published var cookies: [CookieDetail]
    @Published var tabSelection: String = ""
    
    
    var cookieService: CookieService = .init()
    var commentService: CommentServiceProtocol = CookieService()
    
    
    init(cookies: [CookieDetail], selectedCookieId: Int) {
        self.cookies = cookies
        guard let firstCookie = cookies.first(where: { $0.contentId == selectedCookieId }) else { return }
        tabSelection = firstCookie.id
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
}
