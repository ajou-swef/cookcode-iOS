//
//  CookieVideoListViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/05.
//

import SwiftUI

final class CookieVideoListViewModel: ObservableObject, PresentCommentSheet, likeButtonInteractable {
    func likeButtonTapped(_ uuid: String) async {
        guard let index = cookies.firstIndex(where: { $0.id == uuid }) else { return }
        cookies[index].likeInteract()
        
        let _ = await cookieService.likesCookie(cookies[index])
    }
    
    @Published var commentSheetIsPresent: Bool = false
    @Published var cookies: [CookieDetail]
    @Published var tabSelection: String = ""
    @Published var selectedDetail: CookieDetail?
    
    
    var cookieService: CookieService = .init()
    var commentService: CommentServiceProtocol = CookieService()
    
    init(cookies: [CookieDetail], selectedCookieId: Int) {
        self.cookies = cookies
        print("\(cookies)")
        guard let firstCookie = cookies.first(where: { $0.contentId == selectedCookieId }) else { return }
        tabSelection = firstCookie.id
    }
}
