//
//  RecipeSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

final class RecipeSuccessServiceStub: RecipeServiceProtocol {
    func likesContentById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func fetchRecipeCellsByUserId(_ id: Int) async -> Result<ServiceResponse<PageResponse<RecipeCellDto>>, ServiceError> {
        .success(.mock())
    }
    
    func fetchRecipeCells(page: Int, size: Int, search: SearchMembershipType, sort: String?, month: Int?, cookcable: Bool?) async -> Result<ServiceResponse<PageResponse<RecipeCellDto>>, ServiceError> {
        .success(.mock())
    }
    
    func searchRecipeCells(query: String, coockable: Bool, page: Int, size: Int, sort: String?) async -> Result<ServiceResponse<PageResponse<RecipeCellDto>>, ServiceError> {
        .success(.mock())
    }
    
    func fetchCommentsById(_ id: Int) async -> Result<ServiceResponse<PageResponse<CommentDTO>>, ServiceError> {
        .success(.mock())
    }
    
    func deleteCommentById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func postCommentWithId(_ comments: String, id: Int) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func deleteRecipe(recipeId: Int) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func patchRecipe(formDTO: RecipeFormDTO, recipeId: Int) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func postRecipe(_ form: RecipeFormDTO) async -> Result<ServiceResponse<PostRecipeResonse>, ServiceError> {
        .success(.mock())
    }

    
    func searchRecipe(_ recipeID: Int) async -> Result<ServiceResponse<RecipeDetailDTO>, ServiceError> {
        .success(.mock())
    }
}
