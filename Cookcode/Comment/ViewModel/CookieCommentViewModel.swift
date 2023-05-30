//
//  TempCommentable.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import SwiftUI

final class CookieCommentViewModel: Commentable {
    
    
    internal let commentService: CommentServiceProtocol
    
    @Published var comments: [Comment] = .init()
    @Published var commentText: String = "" 
    @Published var pageState: PageState = .wait(0)
    @Published var serviceAlert: ServiceAlert = .init()
    
    @Published var fetchTriggerOffset: CGFloat = .zero
    
    @Published var dragVelocity: CGFloat = .zero
    @Published var scrollOffset: CGFloat = .zero
    
    let spaceName: String = "commentScroll"
    let refreshThreshold: CGFloat = .zero
    
    init() {
        commentService = CookieService()
        comments.append(contentsOf: Comment.mocks(10))
    }
    
    func onRefresh() async {
        
    }
    
    func onFetch() async {
        
    }
    
    func commentUploadButtonTapped() async {
        let result = await commentService.postCommentWithId(commentText, id: 7)
        
        switch result {
        case .success(let success):
            print("댓글 생성 성공")
        case .failure(let failure):
            print("\(failure.localizedDescription)")
        }
    }
}
