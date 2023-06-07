//
//  LikeComponent.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/30.
//

import SwiftUI

struct LikeButton<ViewModel: likeButtonInteractable>: View {
    
    @ObservedObject var viewModel: ViewModel
    let like: any Like
    let color: Color
    let showCounts: Bool
    let width: CGFloat
    
    init(viewModel: ViewModel, like: any Like, color: Color = .white,
         showCounts: Bool = true, width: CGFloat = 30) {
        
        self.viewModel = viewModel
        self.like = like
        self.color = color
        self.showCounts = showCounts
        self.width = width
    }
    
    var body: some View {
        Button {
            Task { await viewModel.likeButtonTapped(like.id) } 
        } label: {
            VStack {
                Image(systemName: like.isLiked ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                    .frame(width: width)
                    .foregroundColor(color)
                
                Text("\(like.likesCount)")
                    .font(CustomFontFactory.INTER_BOLD_16)
                    .foregroundColor(color)
                    .presentIf(showCounts)
            }
        }
    }
}

struct LikeComponent_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton(viewModel: RandomCookieViewModel(cookieService: CookieSuccessService()), like: CookieDetail.mock(), color: .white)
            .preferredColorScheme(.dark)
            
    }
}
