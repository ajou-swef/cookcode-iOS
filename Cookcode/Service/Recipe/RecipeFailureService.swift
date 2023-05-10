//
//  RecipeFailureService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

final class RecipeFailureService: RecipeServiceProtocol {
    func postRecipe(_ form: RecipeFormDTO) async -> Result<ServiceResponse<String>, ServiceError> {
        .failure(.MOCK())
    }
    
    func searchCell(page: Int, size: Int, sort: String, month: Int) async -> Result<[any SearchedCell], ServiceError> {
        return .failure(ServiceError.MOCK())
    }
    
    func searchRecipe(_ recipeID: Int) -> Result<RecipeCellDto, ServiceError> {
        return .failure(ServiceError(message: "조회 실패", status: 400))
    }
    
    func searchRecipeHomeCell(page: Int, size: Int, sort: String, month: Int, cookcable: Bool) -> Result<RecipeCellSeachResponse, ServiceError> {
        return .failure(ServiceError(message: "검색 실패", status: 400))
    }
}
