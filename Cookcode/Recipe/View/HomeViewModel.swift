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
    
    @Published private var pageState: PageState = .wait(0)
    
    @Published var filterType: RecipeFilterType = .all
    
    @Published private var _filterOffset: CGFloat = .zero
    @Published private(set) var contentTypeButtonIsShowing: Bool = false
    
    private let recipeService: RecipeServiceProtocol
    private let pageSize: Int = 10
    
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
        Task { await fetchRecipeCell() }
    }
    
    
    private var searchTriggerIsInScreen: Bool {
        fetchTriggerOffset <= UIScreen.main.bounds.maxY
    }
    
    var firstCellID: String {
        guard let firstCell = recipeCells.first else { return "" }
        return firstCell.id
    }
    
    var hasNoCookcableRecipe: Bool {
        pageState.isNoRemain && recipeCells.isEmpty
    }
    
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
    
    var dragVelocity: CGFloat {
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
    
    var filterOffset: CGFloat {
        _filterOffset
    }
    
    var filterOpacity: CGFloat {
        (20 + _filterOffset) * 2
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
        
        let result = await recipeService.fetchRecipeCells(page: curPage, size: pageSize, sort: nil, month: nil, cookcable: filterType.cookable)
        
        switch result {
        case .success(let success):
            appendRecipeCell(success)
            controllPageState(success, curPage)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
            pageState = .noRemain
        }
    }
    
    private func controllPageState(_ response: ServiceResponse<PageResponse<RecipeCellDto>>, _ curPage: Int) {
        if response.data.content.isEmpty {
            pageState = .noRemain
        } else {
            waitInPage(curPage + 1)
        }
    }
    
    private func waitInPage(_ page: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.pageState = .wait(page)
        }
    }
    
    private func appendRecipeCell(_ success: ServiceResponse<PageResponse<RecipeCellDto>>) {
        let newCells = success.data.content.map {  RecipeCell(dto: $0) }
        recipeCells.append(contentsOf: newCells)
    }
    
    @MainActor
    func updateCell(_ info: [CellType: CellUpdateInfo]) {
        guard let info = info[.recipe] else { return }
        
        print("updateCell called")
        
        switch info.updateType {
        case .delete:
            deleteCell(info.cellId)
        case .patch:
            Task { await patchCell(info.cellId) } 
        }
    }
    
    @MainActor
    private func deleteCell(_ cellId: Int) {
        guard let index = recipeCells.firstIndex(where: { $0.recipeId == cellId }) else { return }
        recipeCells.remove(at: index)
        print("\(index+1)번째 레시피 삭제")
    }
    
    @MainActor
    private func patchCell(_ cellId: Int) async {
        guard let index = recipeCells.firstIndex(where: { $0.recipeId == cellId }) else { return }
        print("\(index+1)번째 레시피 업데이트")
        let page = index / 10
        let result = await recipeService.fetchRecipeCells(page: page, size: pageSize, sort: nil, month: nil, cookcable: filterType.cookable)
        
        switch result {
        case .success(let success):
            let firstIndex = success.data.content.firstIndex { $0.recipeID == cellId }
            guard let matchIndex = firstIndex else { return }
            recipeCells[index] = RecipeCell(dto: success.data.content[matchIndex])
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    @MainActor
    func createContentButtonTapped() {
        contentTypeButtonIsShowing.toggle()
    }
}
