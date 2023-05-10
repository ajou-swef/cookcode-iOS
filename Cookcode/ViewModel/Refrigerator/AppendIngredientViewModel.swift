//
//  AppendIngredientViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/07.
//

import SwiftUI

class AppendIngredientViewModel: SelectIngredientViewModel {
    
    let refridgeratorService: RefrigeratorServiceProtocol
    
    @Published var selectedIngredientCell: IngredientCell?
    
    @Published var searchText: String = ""
    @Published var selectIngredientFormIsPresneted: Bool = false
    
    init (refridgeratorService: RefrigeratorServiceProtocol) {
        self.refridgeratorService = refridgeratorService
    }
    
    func ingredientCellTapped(_ ingredientID: Int) {
        selectedIngredientCell = INGREDIENTS_DICTIONARY[ingredientID]
    }
    
    func isNotSelected(_ ingredientID: Int) -> Bool {
        true
    }
    
    func cancelButtonTapped() {
        selectedIngredientCell = nil
    }
}
