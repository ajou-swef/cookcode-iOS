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
            Text("댓글창")
        }
        .overlay(alignment: .bottom) {
            HStack {
                Image(systemName: "person.fill")
                
                TextField("댓글 추가", text: $viewModel.commentText)
                
                Image(systemName: "arrowshape.turn.up.right.fill")
            }
            .padding(.horizontal, 10)
        }
    }
}

struct CommentComponent_Previews: PreviewProvider {
    static var previews: some View {
        CommentComponent()
    }
}
