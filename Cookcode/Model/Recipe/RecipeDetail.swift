//
//  RecipeDetail.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import Foundation

struct RecipeDetail: Codable {
    let recipeID: Int
    let user: UserDTO
    let title, description, createdAt, updatedAt: String
    let thumbnail: String
    let steps: [StepDTO]
    

    enum CodingKeys: String, CodingKey {
        case recipeID = "recipeId"
        case user, title, description, createdAt, updatedAt, thumbnail, steps
    }
    
    init (dto: RecipeDetailDTO) {
        recipeID = dto.recipeID
        user = dto.user
        title = dto.title
        description = dto.description
        createdAt = dto.createdAt
        updatedAt = dto.updatedAt
        thumbnail = dto.thumbnail
        steps = dto.steps
    }
}
