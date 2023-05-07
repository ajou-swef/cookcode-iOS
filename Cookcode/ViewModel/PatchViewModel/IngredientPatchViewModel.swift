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
    
    init(ingredientId: Int) {
        ingredientForm = Ingredient.FORM(id: ingredientId)
        ingredientCell = INGREDIENTS_DICTIONARY[ingredientId] ?? IngredientCell.Mock()
    }
    
    func trashButtonTapped() {
        print("trashButtonTapped")
    }
    
    func mainButtonTapped() {
        print("mainButtonTapped")
    }
}
