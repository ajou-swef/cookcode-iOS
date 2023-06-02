//
//  RecipePagenableViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/02.
//

import SwiftUI

final class RecipePagenableViewModel: RecipePagenable {
    @Published var recipeCells: [RecipeCell] = .init()
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
}
