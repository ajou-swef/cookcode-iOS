//
//  RecipeSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

final class RecipeSuccessService: RecipeServiceProtocol {
    func postRecipe(_ form: RecipeFormDTO) async -> Result<ServiceResponse<PostRecipeResonse>, ServiceError> {
        .success(.mock())
    }
    
    func searchCell(page: Int, size: Int, sort: String?, month: Int?) async -> Result<[any SearchedCell], ServiceError> {
        .success(RecipeCell.mocks(10))
    }
    
    func searchRecipe(_ recipeID: Int) async -> Result<ServiceResponse<RecipeDetailDTO>, ServiceError> {
        .success(.mock())
    }
    
    func searchRecipeHomeCell(page: Int, size: Int, sort: String?, month: Int?, cookcable: Bool?) async -> Result<RecipeCellSeachResponse, ServiceError> {
        return .success(RecipeCellSeachResponse.MOCK_DATA)
    }
}
