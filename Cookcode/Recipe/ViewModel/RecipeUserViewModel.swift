//
//  RecipeUserViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import SwiftUI

final class RecipeUserViewModel: RecipeFetcher {
    typealias Dto = RecipeCellDto
    typealias T = RecipeCell
    
    @Published var contents: [RecipeCell] = .init()
    @Published var filterType: RecipeFilterType = .all
    @Published var serviceAlert: ViewAlert = .init()
    @Published var pageState: PageState = .wait(0)
    
    internal let recipeService: RecipeServiceProtocol
    internal let pageSize: Int = 10
    private let userId: Int
    @Published var fetchTriggerOffset: CGFloat = .zero
    
    init(recipeService: RecipeServiceProtocol, userId: Int) {
        self.recipeService = recipeService
        self.userId = userId
        
        Task {
            await onFetch()
        }
    }
    
    func appendCell(_ success: ServiceResponse<PageResponse<RecipeCellDto>>) {
        let newCells = success.data.content.map { RecipeCell(dto: $0) }
        contents.append(contentsOf: newCells)
    }
    
    @MainActor
    func onFetch() async {
        let curPage = pageState.page
        pageState = .loading(curPage)
        print("page(\(curPage)) loading start")
        
        let result = await recipeService.fetchRecipeCellsByUserId(userId)
        
        switch result {
        case .success(let success):
            appendCell(success)
            controllPageState(success, curPage)
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
            pageState = .noRemain
        }
    }
}
