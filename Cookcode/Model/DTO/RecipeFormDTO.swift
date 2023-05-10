//
//  RecipeFormDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/10.
//

import Foundation

struct RecipeFormDTO: Encodable {
    let title, description, thumbnail: String
    let ingrediednts, optionalIngredients: [Int]
    let steps: [StepFormDTO]
}
