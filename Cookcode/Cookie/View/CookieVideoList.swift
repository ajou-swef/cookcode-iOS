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
            VTabView(selection: $viewModel.tabSelection) {
                ForEach(viewModel.cookies) { cookie in
                    let url = URL(string: cookie.url)!
                    let avPlayer = AVPlayer(url: url)
                    
                    if cookie.id == viewModel.tabSelection {
                        VideoPlayer(player: avPlayer)
                            .scaledToFill()
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .overlay(alignment: .bottomTrailing) {
                                VStack {
                                    PresentCommentButton(viewModel: viewModel, info: cookie)
                                    LikeButton(viewModel: viewModel, like: cookie, color: .white)
                                }
                                .padding()
                            }
                            .overlay(alignment: .bottomLeading) {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(cookie.title)")
                                        .font(CustomFontFactory.INTER_BOLD_16)

                                    Text("\(cookie.description)")
                                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                                }
                                .padding()
                            }
                    } else {
                        let url = URL(string: cookie.thumbnail)
                        KFImage(url)
                            .resizable()
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
