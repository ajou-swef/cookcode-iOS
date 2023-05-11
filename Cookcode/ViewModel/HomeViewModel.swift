//
//  HomeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/26.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published private(set) var recipeCells: [RecipeCell] = []
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var fetchTriggerOffset: CGFloat = .zero
    
    private let recipeService: RecipeServiceProtocol
    private let fetchSize: Int = 10
    private var pageState: PageState = .wait(0)
    
    
    var searchTriggerIsInScreen: Bool {
        fetchTriggerOffset <= UIScreen.main.bounds.maxY
    }
    
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
        Task { await fetchRecipeCell() }
    }
    
    @MainActor
    func fetchRecipeCell() async {
        
        guard searchTriggerIsInScreen else { return }
        guard pageState.isWaitingState else { return }
        
        let curPage = pageState.page
        pageState = .loading(curPage)
        print("page(\(curPage)) loading start")
        
        let result = await recipeService.searchRecipeHomeCell(page: curPage, size: fetchSize, sort: nil, month: nil, cookcable: nil)
        
        switch result {
        case .success(let success):
            appendRecipeCell(success)
            plueOneAt(curPage)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
            pageBackTo(curPage)
        }
    }
    
    private func plueOneAt(_ curPage: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.pageState = .wait(curPage + 1)
            print("page(\(curPage)) loading success.")
        }
    }
    
    private func pageBackTo(_ curPage: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.pageState = .wait(curPage)
            print("page(\(curPage)) loading fail")
        }
    }
    
    private func appendRecipeCell(_ success: (RecipeCellSeachResponse)) {
        let newCells = success.data.recipeCells.map {  RecipeCell(dto: $0) }
        recipeCells.append(contentsOf: newCells)
    }
}
