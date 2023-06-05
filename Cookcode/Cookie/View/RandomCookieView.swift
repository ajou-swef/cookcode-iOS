//
//  CookieListView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/23.
//

import SwiftUI
import AVKit
import VTabView

struct RandomCookieView: View {
    
    @StateObject private var viewModel = RandomCookieViewModel(cookieService: CookieSuccessService())
    @EnvironmentObject var updateViewModel: UpdateCellViewModel
    
    init() {
        let av = AVPlayerViewController()
        av.view.backgroundColor = UIColor.secondarySystemFill
    }
    
    var body: some View {
        GeometryReader { proxy in
            VTabView(selection: $viewModel.cookieSelection) {
                ForEach(viewModel.cookies) { cookie in
                    if cookie.id == viewModel.cookieSelection {
                        VideoPlayer(player: cookie.avPlayer)
                            .foregroundColor(.blue)
                            .scaledToFill()
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .tag(cookie.id)
                            .overlay(alignment: .bottomTrailing) {
                                VStack {
                                    PresentCommentButton(viewModel: viewModel, info: cookie)
                                    LikeButton(viewModel: viewModel, like: cookie)
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
                        Rectangle()
                            .foregroundColor(.black)
                            .tag(cookie.id)
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
            .onAppear {
                updateViewModel.scheme = .dark
            }
            .onDisappear {
                updateViewModel.scheme = .light
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
        RandomCookieView()
    }
}
