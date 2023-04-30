//
//  RecipeFailureService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

final class RecipeFailureService: RecipeServiceProtocol {
    func fetchRecipe(_ recipeID: Int) -> Result<RecipeCell, ServiceError> {
        return .failure(ServiceError(message: "조회 실패", status: 400))
    }
    
    func searchRecipeHomeCell(page: Int, size: Int, sort: String, month: Int, cookcable: Bool) -> Result<RecipeCellSeachResponse, ServiceError> {
        return .failure(ServiceError(message: "검색 실패", status: 400))
    }
}