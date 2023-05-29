//
//  CommentComponent.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import SwiftUI

struct CommentComponent: View {
    
    @ObservedObject var viewModel = TempCommentable()
    
    var body: some View {
        PagenableComponent(viewModel: viewModel) {
            VStack(alignment: .leading) {
                Text("댓글")
                    .font(.custom(CustomFont.interBold.rawValue, size: 25))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray808080)
                    .padding(.horizontal, -15)
                
                Text("아직 댓글이 없습니다.")
                    .font(.custom(CustomFont.interSemiBold.rawValue, size: 18))
                    .presentIf(viewModel.comments.isEmpty)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
                
                ForEach(viewModel.comments) { comment in
                    CommentCell(comment: comment)
                }
                    
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
            .padding(.horizontal, 15)
        }
        .overlay(alignment: .bottom) {
            HStack {
                Image(systemName: "person.fill")
                
                TextField("댓글 추가", text: $viewModel.commentText)
                
                Image(systemName: "arrowshape.turn.up.right.fill")
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .overlay {
                Rectangle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(.gray_bcbcbc)
            }
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct CommentComponent_Previews: PreviewProvider {
    static var previews: some View {
        CommentComponent()
    }
}
