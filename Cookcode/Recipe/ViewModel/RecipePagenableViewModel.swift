//
//  RecipePagenableViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/02.
//

import SwiftUI

final class RecipePagenableViewModel: RecipePagenable {
    typealias Dto = RecipeCellDto
    typealias T = RecipeCell
    
    @Published var contents: [RecipeCell] = .init()
    @Published var filterType: RecipeFilterType = .all
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var pageState: PageState = .wait(0)
    
    internal let recipeService: RecipeServiceProtocol
    @Published var fetchTriggerOffset: CGFloat = .zero
    internal let pageSize: Int = 10
    
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
        
        Task {
            print("onFetch")
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
        
        let result = await recipeService.fetchRecipeCells(page: curPage, size: pageSize, sort: nil, month: nil, cookcable: filterType.cookable)
        
        switch result {
        case .success(let success):
            appendCell(success)
            controllPageState(success, curPage)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
            pageState = .noRemain
        }
    }
}
