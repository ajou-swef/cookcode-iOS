//
//  RecipeDetailViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/15.
//

import SwiftUI

class RecipeDetailViewModel: RecipeViewModel {
    
    @Published var showDialog: Bool = false
    @Published var commentsComponentIsPresented: Bool = false
    
    var myRecipe: Bool = false
    let recipeId: Int
    init(recipeCell: RecipeCell) {
        recipeId = recipeCell.recipeId
        
        super.init(recipeService: RecipeService(), contentService: ContentSuccessService(), recipeID: recipeId)
        
        Task {
            await fetchRecipe(recipeCell.recipeId)
        }
    }
    
    func deleteButtonTapepd(dismiss: @MainActor () -> ()) async {
        let result = await recipeService.deleteRecipe(recipeId: recipeDetail.recipeID ?? -1)
        switch result {
        case .success(_):
            await dismiss()
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    
    @MainActor
    func fetchRecipe(_ recipeID: Int) async {
        let result = await recipeService.searchRecipe(recipeID)
        switch result {
        case .success(let success):
            recipeDetail = RecipeDetail(dto: success.data)
            setMyRecipe(recipeDetail.user?.userID ?? -1)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    private func setMyRecipe(_ id: Int) {
        let storedId = UserDefaults.standard.object(forKey: USER_ID) as! Int
        if id == storedId {
            myRecipe = true
        }
    }
}
