//
//  CommentCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import SwiftUI
import Kingfisher

struct CommentComponent<ViewModel: CommentCellInteractable>: View {
    
    let comment: Comment
    @ObservedObject var viewModel: ViewModel
    
    init(comment: Comment, viewModel: ViewModel) {
        self.comment = comment
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            userImage()
            
            VStack(alignment: .leading, spacing: 5) {
                Text(comment.user.userName)
                    .font(.custom(CustomFont.interRegular.rawValue, size: 11))
                    .foregroundColor(.gray808080)
                
                Text(comment.comment)
                    .font(.custom(CustomFont.interRegular.rawValue, size: 15))
            }
            
            Spacer()
            
            Button {
                viewModel.commentButtonTapped(comment)
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .presentIf(comment.isMyComment)
                    .foregroundColor(.primary)
            }
        }
        .padding(.bottom, 15)
    }
    
    @ViewBuilder
    private func userImage() -> some View {
        if let url = comment.user.imageURL {
            let url = URL(string: url)
            KFImage(url)
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 30, height: 30)
        }
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentComponent(comment: .mock(), viewModel: CookieCommentViewModel(conentsId: 1, commentService: RecipeSuccessService()))
    }
}
