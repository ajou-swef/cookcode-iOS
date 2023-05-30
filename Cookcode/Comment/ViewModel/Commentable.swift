//
//  Commentable.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import SwiftUI

protocol Commentable: Pagenable {
    var contentId: Int { get }
    var serviceAlert: ServiceAlert { get set }
    var commentService: CommentServiceProtocol { get }
    var commentText: String { get set }
    var comments: [Comment] { get set }
    func commentUploadButtonTapped() async
}

extension Commentable {
//    @MainActor
//    func onFetch() async {
//        let result = await commentService.fetchCommentsById(contentId)
//        switch result {
//        case .success(let success):
//            comments = success.data.map { Comment( }
//        case .failure(let failure):
//            serviceAlert.presentAlert(failure)
//        }
//    }
}
