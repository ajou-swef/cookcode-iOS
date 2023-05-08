//
//  IngredientPatchViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/05.
//

import Foundation

class IngredientPatchViewModel: PatchViewModel {
    
    @Published var ingredientForm: IngredientForm
    @Published private(set) var ingredientCell: IngredientCell
    
    init(ingredientDetail: IngredientDetail) {
        ingredientCell = IngredientCell(detail: ingredientDetail)
        ingredientForm = IngredientForm(detail: ingredientDetail)
    }
    
    func trashButtonTapped() {
        print("trashButtonTapped")
    }
    
    func mainButtonTapped() {
        print("mainButtonTapped")
    }
}
