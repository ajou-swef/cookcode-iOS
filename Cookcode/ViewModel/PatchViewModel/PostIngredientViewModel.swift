//
//  PostIngredientViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/10.
//

import SwiftUI

class PostIngredientViewModel: PatchIngredientViewModel {
    
    @Published var ingredientForm: IngredientForm
    @Published var ingredientCell: IngredientCell
    
    let useTrashButton: Bool = false
    internal let refridgeratorService: RefrigeratorServiceProtocol
    
    init (ingredientCell: IngredientCell, refridgeratorService: RefrigeratorServiceProtocol) {
        ingredientForm = IngredientForm(ingredId: ingredientCell.ingredId)
        self.ingredientCell = ingredientCell
        self.refridgeratorService = refridgeratorService
    }
    
    func trashButtonTapped() {
        print("post trash button")
    }
    
    func mainButtonTapped() {
        print("post main button : \(ingredientForm)")
    }
    
    
}
