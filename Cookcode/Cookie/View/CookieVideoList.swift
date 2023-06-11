//
//  CookieView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/05.
//

import SwiftUI
import VTabView
import AVKit
import Kingfisher

struct CookieVideoList: View {
    
    @StateObject private var viewModel: CookieVideoListViewModel
    @EnvironmentObject var updateViewModel: UpdateCellViewModel
    
    init(cookieDetails: [CookieDetail], selectedCookieId: Int) {
        self._viewModel = StateObject(wrappedValue: CookieVideoListViewModel(cookies: cookieDetails,
                                                                             selectedCookieId: selectedCookieId))
    }
    
    var body: some View {

        GeometryReader { proxy in
            VTabView(selection: $viewModel.cookieSelection) {
                ForEach(viewModel.cookies) { cookie in
                    CookiePlayer(viewModel: viewModel, cookieSelection: viewModel.cookieSelection, cookie: cookie, proxy: proxy)
                        
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .sheet(item: $viewModel.selectedCookie, content: { cookieDetail in
                ModifyCookieView(cookieDetail: cookieDetail)
                    .onDisappear {
                        viewModel.updateCookie(updateViewModel.updateCellDict)
                    }
            })
            .onChange(of: viewModel.cookieSelection) { newValue in
                viewModel.avControll(newValue)
            }
        }
        .onAppear {
            updateViewModel.scheme = .dark
        }
    }
    
//    @ViewBuilder
//    private func cookieVideo(_ cookie: CookieDetail) -> some View {
//        if cookie.id == viewModel.tabSelection {
//            let url = URL(string: cookie.url)!
//            let avPlayer = AVPlayer(url: url)
//            VideoPlayer(player: avPlayer)
//                .foregroundColor(.blue)
//                .scaledToFill()
//                .tag(cookie.id)
//        } else {
//            Rectangle()
//                .foregroundColor(.black)
//                .tag(cookie.id)
//        }
//    }
}

//struct CookieView_Previews: PreviewProvider {
//    static var previews: some View {
//        CookieView()
//    }
//}
