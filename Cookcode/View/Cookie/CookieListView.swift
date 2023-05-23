//
//  CookieListView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/23.
//

import SwiftUI
import AVKit
import VTabView

struct CookieListView: View {
    
    @StateObject private var viewModel = CookieListViewModel()
    
    var body: some View {
        VTabView {
            ForEach(viewModel.avPlayers.indices, id: \.self) { index  in
                GeometryReader { proxy in
                    VideoPlayer(player: viewModel.avPlayers[index])
                        .ignoresSafeArea()
                        .scaledToFill()
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .onAppear {
                            viewModel.avPlayers[index].seek(to: .zero)
                            viewModel.avPlayers[index].play()
                        }
                        .overlay(alignment: .bottomTrailing) {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .aspectRatio(CGSize(width: 4, height: 3.5), contentMode: .fit)
                                .frame(width: 30)
                                .foregroundColor(.white)
                                .padding(.trailing, 20)
                                .padding(.bottom, 30)
                        }
                        .overlay(alignment: .bottomLeading) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("유저이름")
                                    .font(CustomFontFactory.INTER_BOLD_16)
                                
                                Text("2023-05-23")
                                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                            }
                            .padding(.leading, 20)
                            .padding(.bottom, 30)
                        }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxHeight: .infinity)
    }
}

struct CookieListView_Previews: PreviewProvider {
    static var previews: some View {
        CookieListView()
    }
}
