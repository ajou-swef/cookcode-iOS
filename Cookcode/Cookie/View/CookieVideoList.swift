//
//  CookieView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/05.
//

import SwiftUI
import VTabView
import AVKit

struct CookieVideoList: View {
    
    @StateObject private var viewModel: CookieVideoListViewModel
    @EnvironmentObject var updateViewModel: UpdateCellViewModel
    
    init(cookieDetails: [CookieDetail], selectedCookieId: Int) {
        self._viewModel = StateObject(wrappedValue: CookieVideoListViewModel(cookies: cookieDetails,
                                                                             selectedCookieId: selectedCookieId))
    }
    
    var body: some View {

        GeometryReader { proxy in
            VTabView(selection: $viewModel.tabSelection) {
                ForEach(viewModel.cookies) { cookie in
                    let url = URL(string: cookie.url)!
                    let avPlayer = AVPlayer(url: url)
                    
                    if cookie.id == viewModel.tabSelection {
                        VideoPlayer(player: avPlayer)
                            .scaledToFill()
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .overlay(alignment: .bottom) {
                                CookieDetailOverlay(cookieDetail: cookie)
                            }
                    } else {
                        Rectangle()
                            .frame(width: proxy.size.width, height: proxy.size.height)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
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
