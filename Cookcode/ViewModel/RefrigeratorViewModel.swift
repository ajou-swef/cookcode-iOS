//
//  RefrigeratorViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/04.
//

import Foundation

class RefrigeratorViewModel: SelectIngredientViewModel {
    
    @Published var searchText: String = ""
    
    @Published var ingredientFormIsPresented: Bool = false
    @Published var selectIngredientViewIsPresented: Bool = false
    
    func ingredientCellTapped(_ ingredientID: Int) {
        ingredientFormIsPresented = true 
    }
    
    func isNotSelected(_ ingredientID: Int) -> Bool {
        true
    }
    
    
}
