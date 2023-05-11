//
//  RecipeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

final class RecipeViewModel: ObservableObject {
    
    private let recipeService: RecipeServiceProtocol
    
    @Published private(set) var recipeDetail: RecipeDetail?
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var tabSelection: String = ""
    
    init () {
        recipeService = RecipeSuccessService()
    }
    
    init (recipeService: RecipeServiceProtocol, contentService: ContentServiceProtocol, recipeID: Int) {
        self.recipeService = recipeService
        
        Task {
            await fetchRecipe(recipeID)
        }
    }
    
    @MainActor
    func fetchRecipe(_ recipeID: Int) async {
        let result = await recipeService.searchRecipe(recipeID)
        switch result {
        case .success(let success):
            print("\(success.data)")
            recipeDetail = RecipeDetail(dto: success.data)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    func stepID(at :Int) -> String {
        String(recipeDetail?.steps[at].seq ?? 1)
    }
}
