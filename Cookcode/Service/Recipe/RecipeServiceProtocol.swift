//
//  RecipeServiceProtocol.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

protocol RecipeServiceProtocol {
    func searchRecipeHomeCell(page: Int, size: Int, sort: String, month: Int, cookcable: Bool) -> Result<RecipeCellSeachResponse, ServiceError>
    
    func fetchRecipe(_ recipeID: Int) -> Result<RecipeCellDto, ServiceError> 
}
