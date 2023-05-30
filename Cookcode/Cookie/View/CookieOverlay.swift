//
//  CookieDetaliView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import SwiftUI
import AVKit

struct CookieDetailOverlay: View {
    
    let cookieDetail: CookieDetail
    @State private var likes: Bool = false
    @State private var isPresented: Bool = false
    
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 10) {
                Text("\(cookieDetail.title)")
                    .font(CustomFontFactory.INTER_BOLD_16)

                Text("\(cookieDetail.description)")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
            }
            
            Spacer()
            
            VStack(alignment: .center) {
                commnetButton()
                    .padding(.bottom, 20)
                
                likesButton()
            }
        }
        .foregroundColor(.white)
        .padding(.leading, 20)
        .padding(.bottom, 30)
    }
    
    @ViewBuilder
    private func commnetButton() -> some View {
        VStack(alignment: .center) {
            
            Button {
                isPresented = true
            } label: {
                Image(systemName: "ellipsis.bubble.fill")
                    .resizable()
                    .aspectRatio(CGSize(width: 4, height: 3.5), contentMode: .fit)
                    .frame(width: 30)
                    .foregroundColor(.white)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            .sheet(isPresented: $isPresented) {
                CommentComponent(viewModel: CookieCommentViewModel(conentsId: cookieDetail.cookieId, commentService: CookieService()))
            }
            
            Text("\(cookieDetail.commentsCount)")
                .font(CustomFontFactory.INTER_BOLD_16)
        }
    }

    
    @ViewBuilder
    private func likesButton() -> some View {
        VStack(alignment: .center) {
            Button {
                likes.toggle()
            } label: {
                Image(systemName: likes ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(CGSize(width: 4, height: 3.5), contentMode: .fit)
                    .frame(width: 30)
                    .foregroundColor(.white)
            }
            
            Text("\(cookieDetail.likesCount)")
                .font(CustomFontFactory.INTER_BOLD_16)
        }
    }
}

//struct CookieDetaliView_Previews: PreviewProvider {
//    static var previews: some View {
//        CookieDetaliView(cookieSelection: $, cookieDetail: <#CookieDetail#>, proxy: <#GeometryProxy#>)
//    }
//}
