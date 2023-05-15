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
    @Published private var _filterOffset: CGFloat = .zero
    @Published var scrollOffset: CGFloat = .zero
    
    var filterOffset: CGFloat {
        get { _filterOffset }
        set {
            if newValue > 0 {
                _filterOffset = -100
            } else {
                _filterOffset = 0
            }
        }
    }
    
    @Published var filterType: RecipeFilterType = .all {
        didSet {
            Task {
                await resetRecipeCell()
            }
        }
    }
    
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
    func resetRecipeCell() async {
        print("Reset recipe cell: \(filterType.rawValue)")
        pageState = .wait(0)
        
        guard pageState.page == 0 || searchTriggerIsInScreen else { return }
        guard pageState.isWaitingState else { return }
        
        let curPage = pageState.page
        pageState = .loading(curPage)
        print("page(\(curPage)) loading start")
        
        let result = await recipeService.searchRecipeHomeCell(page: curPage, size: fetchSize, sort: nil, month: nil, cookcable: filterType.cookable)
        
        switch result {
        case .success(let success):
            recipeCells = success.data.recipeCells.map { RecipeCell(dto: $0)}
            waitWithPage(curPage + 1)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
            waitWithPage(curPage)
        }
    }
    
    @MainActor
    func fetchRecipeCell() async {
        
        guard searchTriggerIsInScreen else { return }
        guard pageState.isWaitingState else { return }
        
        let curPage = pageState.page
        pageState = .loading(curPage)
        print("page(\(curPage)) loading start")
        
        let result = await recipeService.searchRecipeHomeCell(page: curPage, size: fetchSize, sort: nil, month: nil, cookcable: filterType.cookable)
        
        switch result {
        case .success(let success):
            appendRecipeCell(success)
            waitWithPage(curPage + 1)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
            waitWithPage(curPage)
        }
    }
    
    private func waitWithPage(_ page: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let curPage = self.pageState.page
            self.pageState = .wait(page)
            print("page(\(curPage)) loading success.")
        }
    }
    
    private func appendRecipeCell(_ success: (RecipeCellSeachResponse)) {
        let newCells = success.data.recipeCells.map {  RecipeCell(dto: $0) }
        recipeCells.append(contentsOf: newCells)
    }
}
