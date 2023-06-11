//
//  RecipeCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/02.
//

import Foundation

struct RecipeCell: Identifiable, Mock {
    var type: RecipeCell.Type {
        RecipeCell.self
    }
    
    typealias MockType = RecipeCell
    
    var id: String = UUID().uuidString
    var recipeId: Int
    
    var thumbnail: String
    var title: String
    var likesCount: Int
    var userCell: UserCell
    var createdAt: String
    var isCookable: Bool
    
    init(dto: RecipeCellDto) {
        recipeId = dto.recipeID
        thumbnail = dto.thumbnail
        title = dto.title
        createdAt = dto.createdAt.substring(from: 0, to: 9)
        likesCount = dto.likeCount
        userCell = UserCell(dto: dto.user)
        isCookable = dto.isCookable
    }
    
    static func mock() -> RecipeCell {
        RecipeCell(dto: RecipeCellDto.mock())
    }
}
