//
//  Commentable.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import SwiftUI

protocol Commentable: ObservableObject, CommentCellInteractable {
    var contentId: Int { get }
    var serviceAlert: ServiceAlert { get set }
    var commentService: CommentServiceProtocol { get }
    var commentText: String { get set }
    var comments: [Comment] { get set }
    var deleteAlertIsPresented: Bool { get set } 
    func commentUploadButtonTapped() async
}

extension Commentable {
    
    var commentDisable: Bool {
        commentText.isEmpty
    }
    
    var uploadgButtonIamge: String {
        commentDisable ? "arrowshape.turn.up.right" : "arrowshape.turn.up.right.fill"
    }

    @MainActor
    func onFetch() async {
        let result = await commentService.fetchCommentsById(contentId)
        
        
        switch result {
        case .success(let success):
            
            self.comments = success.data.content.map({  Comment(dto: $0) })
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    
    @MainActor
    func deleteButtonTapped() async {
        guard let comment = selectedComment else { return }
        
        let result = await commentService.deleteCommentById(comment.commentId)
        
        switch result {
        case .success(_):
            await onFetch()
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
        
        selectedComment = nil
    }
}
