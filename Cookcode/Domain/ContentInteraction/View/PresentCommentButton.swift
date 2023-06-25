//
//  PresentCommentButton.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/05.
//

import SwiftUI

struct PresentCommentButton<ViewModel: PresentCommentSheet>: View {
    
    @ObservedObject var viewModel: ViewModel
    let info: any CommentButtonInfo
    
    var body: some View {
        VStack(alignment: .center) {
            Button {
                viewModel.commentSheetIsPresent = true
            } label: {
                Image(systemName: "ellipsis.bubble.fill")
                    .resizable()
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                    .frame(width: 30)
                    .foregroundColor(.white)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            .sheet(isPresented: $viewModel.commentSheetIsPresent) {
                CommentList(viewModel: CookieCommentViewModel(conentsId: info.contentId,
                                                              commentService: viewModel.commentService))
            }
            
            Text("\(info.commentsCount)")
                .font(CustomFontFactory.INTER_BOLD_16)
        }
    }
}
//
//struct PresentCommentButton_Previews: PreviewProvider {
//    static var previews: some View {
//        PresentCommentButton()
//    }
//}
