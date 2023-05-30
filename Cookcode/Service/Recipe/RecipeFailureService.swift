//
//  RecipeFailureService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

final class RecipeFailureService: RecipeServiceProtocol {
    func deleteCommentById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.decodeError())
    }
    
    func fetchCommentsById(_ id: Int) async -> Result<ServiceResponse<[CommentDTO]>, ServiceError> {
        .failure(.decodeError())
    }
    
    func postCommentWithId(_ comments: String, id: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.decodeError())
    }
    
    func deleteRecipe(recipeId: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func patchRecipe(formDTO: RecipeFormDTO, recipeId: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func postRecipe(_ form: RecipeFormDTO) async -> Result<ServiceResponse<PostRecipeResonse>, ServiceError> {
        .failure(.MOCK())
    }
    
    func searchCell(page: Int, size: Int, sort: String?, month: Int?) async -> Result<[any SearchedCell], ServiceError> {
        return .failure(ServiceError.MOCK())
    }
    
    func searchRecipe(_ recipeID: Int) async -> Result<ServiceResponse<RecipeDetailDTO>, ServiceError> {
        return .failure(ServiceError(message: "조회 실패", status: 400))
    }
    
    func searchRecipeHomeCell(page: Int, size: Int, sort: String?, month: Int?, cookcable: Bool?) async -> Result<RecipeCellSeachResponse, ServiceError> {
        return .failure(ServiceError(message: "검색 실패", status: 400))
    }
}
