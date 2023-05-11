//
//  HomeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/26.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published private(set) var recipeCells: [RecipeCell] = []
    @Published var serviceAlert: ServiceAlert = .init()
    
    private let recipeService: RecipeServiceProtocol
    
    
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
        
        Task {
            await fetchRecipeCell()
        }
    }
    
    @MainActor
    private func fetchRecipeCell() async {
        print("fetch")
        let result = await recipeService.searchRecipeHomeCell(page: 0, size: 10, sort: nil, month: nil, cookcable: nil)
        
        switch result {
        case .success(let success):
            let newCells = success.data.recipeCells.map {  RecipeCell(dto: $0) }
            recipeCells.append(contentsOf: newCells)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
}
