//
//  RecipeServiceProtocol.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

protocol RecipeServiceProtocol: CommentServiceProtocol, LikeServiceProtocol {
    func fetchRecipeCellsByUserId(_ id: Int) async -> Result<ServiceResponse<PageResponse<RecipeCellDto>>, ServiceError> 
    
    func searchRecipeCells(query: String, coockable: Bool, page: Int, size: Int) async -> Result<ServiceResponse<PageResponse<RecipeCellDto>>, ServiceError>
    
    func fetchRecipeCells(page: Int, size: Int, sort: String?, month: Int?, cookcable: Bool?) async -> Result<ServiceResponse<PageResponse<RecipeCellDto>>, ServiceError>
    
    func searchRecipe(_ recipeID: Int) async -> Result<ServiceResponse<RecipeDetailDTO>, ServiceError>
    
    func postRecipe(_ form: RecipeFormDTO) async -> Result<ServiceResponse<PostRecipeResonse>, ServiceError>
    
    
    func patchRecipe(formDTO: RecipeFormDTO, recipeId: Int) async -> Result<DefaultResponse, ServiceError>
    
    func deleteRecipe(recipeId: Int) async -> Result<DefaultResponse, ServiceError>
}
