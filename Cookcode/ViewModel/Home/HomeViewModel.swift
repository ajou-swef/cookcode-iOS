//
//  HomeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/26.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    private let resetThreshold: CGFloat = 50
    
    @Published private(set) var recipeCells: [RecipeCell] = []
    @Published var serviceAlert: ServiceAlert = .init()
    
    @Published var fetchTriggerOffset: CGFloat = .zero
    @Published var resetTriggerOffset: CGFloat = .zero
    
    @Published var pageState: PageState = .wait(0)
    @Published var filterType: RecipeFilterType = .all {
        didSet {
            Task {
                await resetRecipeCell()
            }
        }
    }
    @Published private var _filterOffset: CGFloat = .zero
    
    var isLoadingState: Bool{
        pageState.isLoadingState
    }

    var isWaitingState: Bool {
        pageState.isWaitingState
    }
    
    var resetArrowOpacity: CGFloat {
        resetTriggerOffset - resetThreshold
    }
    
    var resetArrowDegree: Double {
        Double(resetTriggerOffset) * 4
    }
    
    var filterOffset: CGFloat {
        get { _filterOffset }
        set {
            if newValue <= 0 && resetTriggerOffset >= resetThreshold {
                Task { await resetRecipeCell() }
            }
            
            if newValue >= 0 {
                _filterOffset = -100
            } else {
                _filterOffset = 0
            }
        }
    }
    
    private let recipeService: RecipeServiceProtocol
    private let fetchSize: Int = 10
    
    
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
        recipeCells.removeAll()
        await fetchRecipeCell()
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
            if success.data.recipeCells.isEmpty {
                pageState = .noRemain
            } else {
                waitInPage(curPage + 1)
            }
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
            waitInPage(curPage)
        }
    }
    
    private func waitInPage(_ page: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let curPage = self.pageState.page
            self.pageState = .wait(page)
            print("page(\(curPage)) loading success.")
            print("isWaitingState? : \(self.isWaitingState)")
        }
    }
    
    private func appendRecipeCell(_ success: (RecipeCellSeachResponse)) {
        let newCells = success.data.recipeCells.map {  RecipeCell(dto: $0) }
        recipeCells.append(contentsOf: newCells)
    }
}
