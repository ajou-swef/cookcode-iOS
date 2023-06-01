//
//  TempCommentable.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import SwiftUI

final class CookieCommentViewModel: Commentable {
    
    internal let contentId: Int 
    internal let commentService: CommentServiceProtocol
    
    @Published var selectedComment: Comment?
    @Published var comments: [Comment] = .init()
    @Published var commentText: String = ""
    @Published var serviceAlert: ServiceAlert = .init()
    
    @Published var deleteAlertIsPresented: Bool = false
    @Published var deleteCommentAlertIsPresented: Comment?
    
    init(conentsId: Int, commentService: CommentServiceProtocol) {
        self.contentId = conentsId
        self.commentService = commentService
        Task { await onFetch() }
    }
    
    @MainActor
    func commentUploadButtonTapped() async {
        let result = await commentService.postCommentWithId(commentText, id: contentId)
        
        commentText = ""
        
        switch result {
        case .success(_):
            await onFetch()
        case .failure(let failure):
            print("\(failure.localizedDescription)")
        }
    }
    
    @MainActor
    func commentButtonTapped(_ comment: Comment) {
        deleteAlertIsPresented = true
        selectedComment = comment
    }
}
