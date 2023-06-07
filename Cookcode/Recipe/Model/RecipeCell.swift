//
//  RecipeCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/02.
//

import Foundation

struct RecipeCell: SearchedCell {
    
    
    var createdAt: String
    
    
    var type: RecipeCell.Type {
        RecipeCell.self
    }
    
    typealias MockType = RecipeCell
    
    var id: String = UUID().uuidString
    var recipeId: Int
    
    var thumbnail: String
    var title: String
    var userName: String
    var userProfile: String?
    var likesCount: Int
    
    init(dto: RecipeCellDto) {
        recipeId = dto.recipeID
        thumbnail = dto.thumbnail
        title = dto.title
        userName = dto.user.nickname
        createdAt = dto.createdAt.substring(from: 0, to: 9)
        userProfile = dto.user.profileImage
        likesCount = dto.likeCount
    }
    
    static func mock() -> RecipeCell {
        RecipeCell(dto: RecipeCellDto.mock())
    }
}
