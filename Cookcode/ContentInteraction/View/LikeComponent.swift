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
    
    var body: some View {
        Button {
            Task { await viewModel.likeButtonTapped(like.id) } 
        } label: {
            VStack {
                Image(systemName: like.isLiked ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                    .frame(width: 30)
                    .foregroundColor(.white)
                
                Text("\(like.likesCount)")
                    .font(CustomFontFactory.INTER_BOLD_16)
                    .foregroundColor(.white)
            }
        }
    }
}

struct LikeComponent_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton(viewModel: RandomCookieViewModel(cookieService: CookieSuccessService()), like: CookieDetail.mock())
            .preferredColorScheme(.dark)
            
    }
}
