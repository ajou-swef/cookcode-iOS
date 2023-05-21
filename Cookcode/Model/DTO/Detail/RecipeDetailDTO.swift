//
//  RecipeDetailDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import Foundation

struct RecipeDetailDTO: Codable, Mock {
    static func mock() -> RecipeDetailDTO {
        RecipeDetailDTO(recipeID: 1, user: UserDTO.MOCK_DATA, title: "title", description: "description", ingredients: IngredientDTO.mocks(5), optionalIngredients: IngredientDTO.mocks(2), steps: StepDTO.mocks(1), createdAt: "2023-03-03", updatedAt: "2023-03-03", thumbnail: "")
    }
    
    let recipeID: Int
    let user: UserDTO
    let title, description: String
    let ingredients: [IngredientDTO]
    let optionalIngredients: [IngredientDTO]
    let steps: [StepDTO]
    let createdAt, updatedAt, thumbnail: String

    enum CodingKeys: String, CodingKey {
        case recipeID = "recipeId"
        case user, title, description, ingredients, optionalIngredients, steps, createdAt, updatedAt, thumbnail
    }
}
