//
//  RecipeDetail.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import Foundation
import cookcode_service

struct RecipeDetail: Like {
    var id: String = UUID().uuidString
    var isLiked: Bool
    var likesCount: Int
    let recipeID: Int?
    let user: UserCellDTO?
    let title, description: String
    let createdAt, updatedAt: String?
    var commentsCount: Int
    let thumbnail: String
    var steps: [StepDTO]
    var ingredientCells: [IngredientCell]
    var optionalIngredientCells: [IngredientCell]
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
        isLiked = dto.isLiked
        likesCount = dto.likeCount
        commentsCount = dto.commentCount
    }
    
    init (form: RecipeForm) {
        title = form.title
        description = form.description
        thumbnail = form.thumbnail
        
        steps = []
        for (index, value) in form.steps.enumerated() {
            steps.append(value.convertStepDTO(sequence: index))
        }
        recipeID = nil
        user = nil
        createdAt = nil
        updatedAt = nil
        
        ingredientCells = form.ingredients.map { IngredientCell(ingredientId: $0) }
        optionalIngredientCells = form.optionalIngredients.map { IngredientCell(ingredientId: $0) }
        isLiked = false
        likesCount = 0
        commentsCount = 0
    }
}
