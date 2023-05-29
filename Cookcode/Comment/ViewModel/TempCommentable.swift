//
//  TempCommentable.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import SwiftUI

final class TempCommentable: Commentable {
    @Published var comments: [Comment] = .init()
    @Published var commentText: String = "" 
    @Published var pageState: PageState = .wait(0)
    
    @Published var fetchTriggerOffset: CGFloat = .zero
    
    @Published var dragVelocity: CGFloat = .zero
    @Published var scrollOffset: CGFloat = .zero
    
    let spaceName: String = "commentScroll"
    let refreshThreshold: CGFloat = .zero
    
    init() {
        comments.append(contentsOf: Comment.mocks(10))
    }
    
    func onRefresh() async {
        
    }
    
    func onFetch() async {
        
    }
    
    func commentUploadButtonTapped() {
        
    }
}
