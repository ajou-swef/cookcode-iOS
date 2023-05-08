//
//  AppendIngredientViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/07.
//

import SwiftUI

class AppendIngredientViewModel: SelectIngredientViewModel {
    
    let refridgeratorService: RefrigeratorServiceProtocol
    
    @Published var ingredientForm: IngredientForm = .init(ingredId: 1)
    @Published var searchText: String = ""
    
    @Published var ingredientFormIsPresented: Bool = false
    @Published var selectIngredientFormIsPresneted: Bool = false
    
    init (refridgeratorService: RefrigeratorServiceProtocol) {
        self.refridgeratorService = refridgeratorService
    }
    
    func ingredientCellTapped(_ ingredientID: Int) {
        ingredientForm = IngredientForm(ingredId: ingredientID)
        ingredientFormIsPresented = true 
    }
    
    func isNotSelected(_ ingredientID: Int) -> Bool {
        true
    }
    
    func cancelButtonTapped() {
        ingredientFormIsPresented = false
    }
}
