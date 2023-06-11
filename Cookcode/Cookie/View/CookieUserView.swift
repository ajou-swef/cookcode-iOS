//
//  CookieUserView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import SwiftUI
import Kingfisher

struct CookieUserView: View {
    
    @StateObject private var viewModel: CookieUserViewModel
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @EnvironmentObject var updateViewModel: UpdateCellViewModel
    
    init(cookieService: CookieServiceProtocol = CookieService(), userId: Int) {
        self._viewModel = StateObject(wrappedValue: CookieUserViewModel(cookieService: cookieService,
                                                                        userId: userId))
    }
    
    var body: some View {
        PagenableComponent(viewModel: viewModel) {
            LazyVGrid(columns: viewModel.columns) {
                ForEach(viewModel.contents) { cookieCell in
                    NavigationLink {
                        CookieVideoList(cookieDetails: viewModel.contents,
                                        selectedCookieId: cookieCell.contentId)
                    } label: {
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
        .onAppear {
            updateViewModel.scheme = .light
            Task { await viewModel.refresh() }
            
        }
    }
}

struct CookieUserView_Previews: PreviewProvider {
    static var previews: some View {
        CookieUserView(cookieService: CookieSuccessService(), userId: 1)
    }
}
