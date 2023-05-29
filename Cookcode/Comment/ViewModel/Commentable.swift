//
//  Commentable.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import Foundation

protocol Commentable: Pagenable {
    var commentText: String { get set }
    var comments: [Comment] { get set }
    func commentUploadButtonTapped()
}
