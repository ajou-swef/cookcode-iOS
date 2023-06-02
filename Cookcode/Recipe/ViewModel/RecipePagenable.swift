//
//  PagenableRecipe.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/02.
//

import SwiftUI

protocol RecipePagenable: Pagenable {
    var recipeCells: [RecipeCell] { get set }
    var recipeService: RecipeServiceProtocol { get }
    var filterType: RecipeFilterType { get set }
    var serviceAlert: ServiceAlert { get set }
}

extension RecipePagenable {
    
    @MainActor
    func onFetch() async {
        let curPage = pageState.page
        pageState = .loading(curPage)
        print("page(\(curPage)) loading start")
        
        let result = await recipeService.searchRecipeHomeCell(page: curPage, size: pageSize, sort: nil, month: nil, cookcable: filterType.cookable)
        
        switch result {
        case .success(let success):
            appendRecipeCell(success)
            controllPageState(success, curPage)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
            pageState = .noRemain
        }
    }
    
    func controllPageState(_ response: RecipeCellSeachResponse, _ curPage: Int) {
        if response.data.recipeCells.isEmpty {
            pageState = .noRemain
        } else {
            waitInPage(curPage + 1)
        }
    }
    
    func waitInPage(_ page: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.pageState = .wait(page)
        }
    }
    
    func appendRecipeCell(_ success: (RecipeCellSeachResponse)) {
        let newCells = success.data.recipeCells.map {  RecipeCell(dto: $0) }
        recipeCells.append(contentsOf: newCells)
    }
    
}
