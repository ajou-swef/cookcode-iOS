//
//  RecipeDetail.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import Foundation

struct RecipeDetail {
    let recipeID: Int?
    let user: UserDTO?
    let title, description: String
    let createdAt, updatedAt: String?
    let thumbnail: String
    var steps: [StepDTO]
    var ingredientCells: [IngredientCell]
    var optionalIngredientCells: [IngredientCell]
    

    enum CodingKeys: String, CodingKey {
        case recipeID = "recipeId"
        case user, title, description, createdAt, updatedAt, thumbnail, steps
    }
}

extension RecipeDetail {
    init (dto: RecipeDetailDTO) {
        recipeID = dto.recipeID
        user = dto.user
        title = dto.title
        description = dto.description
        createdAt = dto.createdAt
        updatedAt = dto.updatedAt
        thumbnail = dto.thumbnail
        steps = dto.steps
        ingredientCells = dto.ingredients.map { IngredientCell(ingredientDTO: $0) }
        optionalIngredientCells = dto.optionalIngredients.map { IngredientCell(ingredientDTO: $0) }
    }
    
    init (form: RecipeForm) {
        title = form.title
        description = form.description
        thumbnail = form.thumbnail
        
        steps = []
        steps = form.steps.map { StepDTO(form: $0) }
        recipeID = nil
        user = nil
        createdAt = nil
        updatedAt = nil
        
        ingredientCells = []
        optionalIngredientCells = []
    }
}
