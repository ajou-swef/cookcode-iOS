//
//  Comment.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import SwiftUI

struct Comment: Identifiable, Mock {
    
    static func mock() -> Comment {
        Comment(user: .mock(), comment: "댓글")
    }
    
    let id: String = UUID().uuidString
    let user: UserCell
    let comment: String
}

extension Comment {
    init(dto: CommentDTO) {
        user = UserCell(dto: dto.user)
        comment = dto.comment
    }
}

struct CommentDTO: Codable, Mock {
    static func mock() -> CommentDTO {
        CommentDTO(id: 1, user: .MOCK_DATA, comment: "댓글")
    }
    
    let id: Int
    let user: UserDTO
    let comment: String
}

