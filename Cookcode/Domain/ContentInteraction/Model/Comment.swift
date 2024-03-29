//
//  Comment.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import SwiftUI

struct Comment: Identifiable, Mock {
    
    static func mock() -> Comment {
        Comment(commentId: 1, user: .mock(), comment: "댓글", isMyComment: true)
    }
    
    let id: String = UUID().uuidString
    let commentId: Int
    let user: UserCell
    let comment: String
    let isMyComment: Bool
}

extension Comment {
    init(dto: CommentDTO) {
        user = UserCell(dto: dto.user)
        comment = dto.comment
        commentId = dto.commentId
        
        let id = UserDefaults.standard.integer(forKey: USER_ID)
        isMyComment = (id == dto.user.userID)
    }
}

struct CommentDTO: Decodable, Mock {
    static func mock() -> CommentDTO {
        CommentDTO(commentId: 1, user: .mock(), comment: "댓글")
    }
    
    let commentId: Int
    let user: UserCellDto
    let comment: String
}

