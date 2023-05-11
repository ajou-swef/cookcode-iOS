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
    @Published var pagenagationTriggerOffset: CGFloat = .zero
    
    private(set) var pageState: PageState = .wait(0)
    private let recipeService: RecipeServiceProtocol
    
    
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
        
        Task {
            await fetchRecipeCell()
        }
    }
    
    @MainActor
    func fetchRecipeCell() async {
        switch pageState {
        case .loading(_):
            break
        case .wait(let page):
            pageState = .loading(page)
            let result = await recipeService.searchRecipeHomeCell(page: page, size: 10, sort: nil, month: nil, cookcable: nil)
            
            switch result {
            case .success(let success):
                print("new fetch start")
                pageState = .wait(page + 1)
                let newCells = success.data.recipeCells.map {  RecipeCell(dto: $0) }
                recipeCells.append(contentsOf: newCells)
            case .failure(let failure):
                pageState = .wait(page)
                serviceAlert.presentAlert(failure)
            }
        }
    }
}
