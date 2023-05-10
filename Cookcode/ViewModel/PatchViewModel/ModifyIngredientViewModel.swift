//
//  IngredientPatchViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/05.
//

import Foundation

class ModifyIngredientViewModel: PatchIngredientViewModel {
    
    
    
    internal let useTrashButton: Bool = true
    @Published var ingredientForm: IngredientForm
    @Published var ingredientCell: IngredientCell
    
    internal let refridgeratorService: RefrigeratorServiceProtocol
    
    init(ingredientDetail: IngredientDetail, refridgeratorService: RefrigeratorServiceProtocol) {
        ingredientCell = IngredientCell(detail: ingredientDetail)
        ingredientForm = IngredientForm(detail: ingredientDetail)
        self.refridgeratorService = refridgeratorService
    }
    
    func trashButtonTapped() {
        print("trashButtonTapped")
    }
    
    func mainButtonTapped() {
        print("mainButtonTapped")
    }
}
