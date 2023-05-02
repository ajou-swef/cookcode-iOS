//
//  RecipeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

final class RecipeViewModel: ObservableObject {
    
    private let recipeService: RecipeServiceProtocol
    
    @Published private(set) var recipeDetail: RecipeCellDto?
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var tabSelection: String = ""
    
    init () {
        recipeService = RecipeFailureService()
    }
    
    init (recipeService: RecipeServiceProtocol, contentService: ContentServiceProtocol, recipeID: Int) {
        self.recipeService = recipeService
        fetchRecipe(recipeID)
    }
    
    func fetchRecipe(_ recipeID: Int) {
        let result = recipeService.searchRecipe(recipeID)
        switch result {
        case .success(let success):
            recipeDetail = success
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    func stepID(at :Int) -> String {
        String(recipeDetail?.steps[at].id ?? "id")
    }
}
