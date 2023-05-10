//
//  PostIngredientViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/10.
//

import SwiftUI

class PostIngredientViewModel: PatchIngredientViewModel {
    var ingredientForm: IngredientForm
    
    var ingredientCell: IngredientCell
    
    var useTrashButton: Bool = false
    
    init (ingredientCell: IngredientCell) {
        ingredientForm = IngredientForm(ingredId: ingredientCell.ingredId)
        self.ingredientCell = ingredientCell
    }
    
    func trashButtonTapped() {
        print("post trash button")
    }
    
    func mainButtonTapped() {
        print("post main button : \(ingredientForm)")
    }
    
    
}
