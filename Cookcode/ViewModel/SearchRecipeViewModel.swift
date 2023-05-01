//
//  SearchRecipeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation
import SwiftUI

class SearchRecipeViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var recipeCellSearch: RecipeCellSearch = .init()
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var searchType: SearchType = .recipe

    let recipeService: RecipeServiceProtocol
    let columns: [GridItem] = [
        GridItem(.flexible())
    ]
    let recipeCellHeight: CGFloat = 200
    
    init (recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
    }
    
    func searchRecipe() {
        let result = recipeService.searchRecipeHomeCell(page: recipeCellSearch.pageNumber, size: recipeCellSearch.pageSize, sort: "createdAt", month: 1, cookcable: true)
        
        switch result {
        case .success(let success):
            recipeCellSearch.update(success.data)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
}
