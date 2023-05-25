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
    
    @StateObject private var viewModel = CookieListViewModel(cookieService: CookieService())
    
    init() {
        let av = AVPlayerViewController()
        av.view.backgroundColor = UIColor.secondarySystemFill
    }
    
    var body: some View {
        GeometryReader { proxy in
            VTabView(selection: $viewModel.cookieSelection) {
                ForEach(viewModel.cookies.indices, id: \.self) { i in
                    if viewModel.cookies[i].id == viewModel.cookieSelection {
                        let url = URL(string: viewModel.cookies[i].url)!
                        let avPlayer = AVPlayer(url: url)

                        VideoPlayer(player: avPlayer)
                            .foregroundColor(.blue)
                            .scaledToFill()
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .overlay(alignment: .bottomTrailing) {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .aspectRatio(CGSize(width: 4, height: 3.5), contentMode: .fit)
                                    .frame(width: 30)
                                    .padding(.trailing, 20)
                                    .padding(.bottom, 30)
                                    .foregroundColor(.white)
                            }
                            .overlay(alignment: .bottomLeading) {
                                bottomItem(i)
                            }
                            .tag(viewModel.cookies[i].id)
                    } else {
                        Rectangle()
                            .foregroundColor(.black)
                            .tag(viewModel.cookies[i].id)
                            .overlay(alignment: .bottomLeading) {
                                bottomItem(i)
                            }
                    }
                }
            }
            .simultaneousGesture(
                DragGesture()
                    .onChanged({ gesture in
                        viewModel.drag = -1 * gesture.translation.height
                    })
            )
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: viewModel.cookieSelection) { newValue in
                Task { await viewModel.loadNewCookie() } 
            }
            .onChange(of: viewModel.drag) { newValue in
                viewModel.rotateTab()
            }
        }
    }
    
    @ViewBuilder
    private func bottomItem(_ index: Int) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(viewModel.cookies[index].title)")
                .font(CustomFontFactory.INTER_BOLD_16)

            Text("\(viewModel.cookies[index].description)")
                .font(CustomFontFactory.INTER_SEMIBOLD_14)
        }
        .foregroundColor(.white)
        .padding(.leading, 20)
        .padding(.bottom, 30)
    }
}

struct CookieListView_Previews: PreviewProvider {
    static var previews: some View {
        CookieListView()
    }
}
