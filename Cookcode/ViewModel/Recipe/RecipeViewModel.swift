//
//  RecipeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

class RecipeViewModel: ObservableObject {
    
    let recipeService: RecipeServiceProtocol
    
    @Published var recipeDetail: RecipeDetail = .init(dto: .mock())
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var tabSelection: String = ""
    
    init () {
        recipeService = RecipeSuccessService()
    }
    
    init (recipeService: RecipeServiceProtocol, contentService: ContentServiceProtocol, recipeID: Int?) {
        self.recipeService = recipeService
        
        Task {
            if let recipeID = recipeID {
                await fetchRecipe(recipeID)
            }
        }
    }
    
    @MainActor
    func fetchRecipe(_ recipeID: Int) async {
        let result = await recipeService.searchRecipe(recipeID)
        switch result {
        case .success(let success):
            recipeDetail = RecipeDetail(dto: success.data)
            print("recipeDetail: \(recipeDetail)")
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
//    func stepID(at :Int) -> String {
//        String(recipeDetail?.steps[at].seq ?? 1)
//    }
}
