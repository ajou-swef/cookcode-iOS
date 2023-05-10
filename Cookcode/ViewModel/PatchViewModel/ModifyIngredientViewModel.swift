//
//  IngredientPatchViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/05.
//

import Foundation

class ModifyIngredientViewModel: PatchIngredientViewModel {
    internal let useTrashButton: Bool
    @Published var ingredientForm: IngredientForm
    @Published var ingredientCell: IngredientCell
    
    init(ingredientDetail: IngredientDetail) {
        ingredientCell = IngredientCell(detail: ingredientDetail)
        ingredientForm = IngredientForm(detail: ingredientDetail)
        useTrashButton = true
    }
    
    func trashButtonTapped() {
        print("trashButtonTapped")
    }
    
    func mainButtonTapped() {
        print("mainButtonTapped")
    }
}
