//
//  RecipeDetailViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/15.
//

import SwiftUI

class RecipeDetailViewModel: RecipeViewModel, likeButtonInteractable {
    @Published var showDialog: Bool = false
    @Published var commentsComponentIsPresented: Bool = false
    @Published var isLoading: Bool = true
    
    var myRecipe: Bool = false
    let recipeId: Int
    
    init(recipeId: Int) {
        self.recipeId = recipeId
        super.init(recipeService: RecipeService(), contentService: ContentSuccessService(), recipeID: recipeId)
        
        Task {
            await fetchRecipe(recipeId)
        }
    }
    
    func deleteButtonTapepd(dismiss: @MainActor () -> ()) async {
        let result = await recipeService.deleteRecipe(recipeId: recipeDetail.recipeID ?? -1)
        switch result {
        case .success(_):
            await dismiss()
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
        }
    }
    
    
    @MainActor
    func fetchRecipe(_ recipeID: Int) async {
        let result = await recipeService.searchRecipe(recipeID)
        switch result {
        case .success(let success):
            isLoading = false
            recipeDetail = RecipeDetail(dto: success.data)
            setMyRecipe(recipeDetail.user?.userID ?? -1)
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
        }
    }
    
    private func setMyRecipe(_ id: Int) {
        let storedId = UserDefaults.standard.object(forKey: USER_ID) as! Int
        if id == storedId {
            myRecipe = true
        }
    }
    
    @MainActor
    func likeButtonTapped(_ uuid: String) async {
        recipeDetail.likeInteract()
        let _ = await recipeService.likesContentById(recipeDetail.recipeID ?? -1)
    }
}
