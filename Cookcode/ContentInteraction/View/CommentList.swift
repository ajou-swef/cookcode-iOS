//
//  CommentComponent.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import SwiftUI

struct CommentList<ViewModel: Commentable>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("댓글")
                    .font(.custom(CustomFont.interBold.rawValue, size: 25))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray808080)
                    .padding(.horizontal, -15)
                    .padding(.bottom, 10)
                
                Text("아직 댓글이 없습니다.")
                    .font(.custom(CustomFont.interSemiBold.rawValue, size: 18))
                    .presentIf(viewModel.comments.isEmpty)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
                
                ForEach(viewModel.comments) { comment in
                    CommentComponent(comment: comment, viewModel: viewModel)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
            .padding(.horizontal, 15)
        }
        .alert("삭제하시겠습니까?", isPresented: $viewModel.deleteAlertIsPresented, actions: {
            Button("취소", role: .cancel) { }
            Button("삭제") {
                Task { await viewModel.deleteButtonTapped() }
            }
        })
        .overlay(alignment: .bottom) {
            HStack {
                Image(systemName: "person.fill")
                
                TextField("댓글 추가", text: $viewModel.commentText)
                
                Button {
                    Task { await viewModel.commentUploadButtonTapped() }
                } label: {
                    Image(systemName: viewModel.uploadgButtonIamge)
                }
                .disabled(viewModel.commentDisable)
                
                
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
        .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
            ViewAlert.cancelButton
        }
    }
}

struct CommentComponent_Previews: PreviewProvider {
    static var previews: some View {
        CommentList(viewModel: CookieCommentViewModel(conentsId: 1, commentService: RecipeSuccessServiceStub()))
    }
}
