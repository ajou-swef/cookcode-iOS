//
//  CookieSearchView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/05.
//

import SwiftUI
import Kingfisher

struct CookieSearchView: View {
    
    @StateObject private var viewModel: CookieSearchViewModel
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    
    init(cookieService: CookieServiceProtocol = CookieService(), query: String) {
        self._viewModel = StateObject(wrappedValue: CookieSearchViewModel(cookieService: cookieService, query: query))
    }
    
    var body: some View {
        RefreshComponent(viewModel: viewModel) {
            PagenableComponent(viewModel: viewModel) {
                LazyVGrid(columns: viewModel.columns) {
                    ForEach(viewModel.contents) { cookieCell in
                        if cookieCell.thumbnail.isEmpty {
                            Rectangle()
                                .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fill)
                        } else {
                            let url = URL(string: cookieCell.thumbnail)
                            KFImage(url)
                                .resizable()
                                .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fill)
                        }
                    }
                }
            }
        }
    }
}

struct CookieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        CookieSearchView(cookieService: CookieSuccessService(), query: "query")
    }
}
