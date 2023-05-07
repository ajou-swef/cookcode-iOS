//
//  RecipeSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

final class RecipeSuccessService: RecipeServiceProtocol {
    func searchCell(page: Int, size: Int, sort: String, month: Int) async -> Result<[any SearchedCell], ServiceError> {
        .success(RecipeCell.mocks(10))
    }
    
    func searchRecipe(_ recipeID: Int) -> Result<RecipeCellDto, ServiceError> {
        return .success(RecipeCellDto.MOCK_DATA)
    }
    
    func searchRecipeHomeCell(page: Int, size: Int, sort: String, month: Int, cookcable: Bool) -> Result<RecipeCellSeachResponse, ServiceError> {
        return .success(RecipeCellSeachResponse.MOCK_DATA)
    }
}
