//
//  RecipeFailureService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

final class RecipeFailureService: RecipeServiceProtocol {
    func likesContentById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func fetchRecipeCellsByUserId(_ id: Int) async -> Result<ServiceResponse<PageResponse<RecipeCellDto>>, ServiceError> {
        .failure(.MOCK())
    }
    
    func fetchRecipeCells(page: Int, size: Int, sort: String?, month: Int?, cookcable: Bool?) async -> Result<ServiceResponse<PageResponse<RecipeCellDto>>, ServiceError> {
        .failure(.MOCK())
    }
    
    func searchRecipeCells(query: String, coockable: Bool, page: Int, size: Int) async -> Result<ServiceResponse<PageResponse<RecipeCellDto>>, ServiceError> {
        .failure(.MOCK())
    }
    
    func fetchCommentsById(_ id: Int) async -> Result<ServiceResponse<PageResponse<CommentDTO>>, ServiceError> {
        .failure(.decodeError())
    }
    
    func deleteCommentById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
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
    
    func searchRecipe(_ recipeID: Int) async -> Result<ServiceResponse<RecipeDetailDTO>, ServiceError> {
        return .failure(ServiceError(message: "조회 실패", status: 400))
    }
}
