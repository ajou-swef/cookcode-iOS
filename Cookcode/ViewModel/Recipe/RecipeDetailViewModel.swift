//
//  RecipeDetailViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/15.
//

import SwiftUI

class RecipeDetailViewModel: RecipeViewModel {
    
    init(recipeCell: RecipeCell) {
        super.init(recipeService: RecipeService(), contentService: ContentSuccessService(), recipeID: recipeCell.recipeId)
    }
}
