//
//  CookieVideoListViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/05.
//

import SwiftUI

final class CookieVideoListViewModel: ObservableObject {
    let cookies: [CookieDetail]
    @Published var tabSelection: String = ""
    
    init(cookies: [CookieDetail], selectedCookieId: Int) {
        self.cookies = cookies
        print("\(cookies)")
        guard let firstCookie = cookies.first(where: { $0.cookieId == selectedCookieId }) else { return }
        tabSelection = firstCookie.id
    }
}
