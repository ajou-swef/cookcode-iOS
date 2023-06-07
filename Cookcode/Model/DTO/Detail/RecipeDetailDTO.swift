//
//  RecipeDetailDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import Foundation

struct RecipeDetailDTO: Decodable, Mock {
    static func mock() -> RecipeDetailDTO {
        RecipeDetailDTO(recipeID: 1, user: .mock(), title: "title", description: "description", ingredients: IngredientDTO.mocks(5), optionalIngredients: IngredientDTO.mocks(2), steps: StepDTO.mocks(1), createdAt: "2023-03-03", updatedAt: "2023-03-03", thumbnail: "", isLiked: false, likeCount: 31, commentCount: 11)
    }
    
    let recipeID: Int
    let user: UserCellDto
    let title, description: String
    let ingredients: [IngredientDTO]
    let optionalIngredients: [IngredientDTO]
    let steps: [StepDTO]
    let createdAt, updatedAt, thumbnail: String
    let isLiked: Bool
    let likeCount: Int
    let commentCount: Int

    enum CodingKeys: String, CodingKey {
        case recipeID = "recipeId"
        case user, title, description, ingredients, optionalIngredients, steps, createdAt, updatedAt, thumbnail
        case isLiked, likeCount, commentCount
    }
}
