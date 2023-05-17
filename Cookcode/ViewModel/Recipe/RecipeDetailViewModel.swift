//
//  RecipeDetailViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/15.
//

import SwiftUI

class RecipeDetailViewModel: RecipeViewModel {
    
    @Published var showDialog: Bool = false
    
    var myRecipe: Bool = false
    
    init(recipeCell: RecipeCell) {
        super.init(recipeService: RecipeService(), contentService: ContentSuccessService(), recipeID: recipeCell.recipeId)
        
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
            print("recipeDetail: \(recipeDetail)")
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
