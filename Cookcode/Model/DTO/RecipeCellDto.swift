//
//  Recipe.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

struct RecipeCellDto: Codable, Hashable, Mock {
    static func mock() -> RecipeCellDto {
        RecipeCellDto(recipeID: 1, user: UserDTO.MOCK_DATA, title: "title", description: "description", ingredients: IngredientDTO.mocks(1), optionalIngredients: IngredientDTO.mocks(1), createdAt: "2023-12-12", updatedAt: "2023-12-14", thumbnail: "")
    }
    
    let recipeID: Int
     let user: UserDTO
     let title, description: String
     let ingredients, optionalIngredients: [IngredientDTO]
     let createdAt, updatedAt, thumbnail: String

     enum CodingKeys: String, CodingKey {
         case recipeID = "recipeId"
         case user, title, description, ingredients, optionalIngredients, createdAt, updatedAt, thumbnail
     }
}
