//
//  CookiePlayer.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI
import Kingfisher
import AVKit

struct CookiePlayer<ViewModel: likeButtonInteractable & PresentCommentSheet & CookieInteractable>: View {
    @ObservedObject var viewModel: ViewModel
    let cookieSelection: String
    let cookie: CookieDetail
    let proxy: GeometryProxy
    
    var body: some View {
        if cookie.id == cookieSelection {
            VideoPlayer(player: cookie.avPlayer)
                .foregroundColor(.blue)
                .scaledToFill()
                .frame(width: proxy.size.width, height: proxy.size.height)
                .tag(cookie.id)
                .onDisappear {
                    cookie.avPlayer?.pause()
                }
                .overlay(alignment: .topTrailing, content: {
                    Button {
                        viewModel.cookieInteractButtonTapped(cookie)
                    } label: {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .frame(width: 30, height: 6)
                            .foregroundColor(.white)
                            .padding(.vertical)
                    }
                    .presentIf(cookie.isMyCookie)

                })
                .overlay(alignment: .bottomTrailing) {
                    VStack {
                        PresentCommentButton(viewModel: viewModel, info: cookie)
                        LikeButton(viewModel: viewModel, like: cookie, color: .white)
                    }
                    .padding()
                }
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        HStack {
                            ProfileNavigateButton(userCell: cookie.userCell, width: 30)
                            
                            Text("\(cookie.userCell.userName)")
                                .font(.custom(CustomFont.interSemiBold.rawValue, size: 15))
                                .foregroundColor(.white)
                        }
                        
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
//
//struct CookiePlayer_Previews: PreviewProvider {
//    static var previews: some View {
//        CookiePlayer()
//    }
//}
