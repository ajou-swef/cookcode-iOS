//
//  AppendIngredientViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/07.
//

import SwiftUI

class AppendIngredientViewModel: SelectIngredientViewModel {
    
    @Published var searchText: String = ""
    
    @Published private(set) var ingredinetId: Int?
    @Published var ingredientQuantity: String = ""
    @Published var date: Date = .now
    
    @Published var ingredientFormIsPresented: Bool = false
    @Published var selectIngredientFormIsPresneted: Bool = false
    
    func ingredientCellTapped(_ ingredientID: Int) {
        self.ingredinetId = ingredientID
        ingredientFormIsPresented = true 
    }
    
    func isNotSelected(_ ingredientID: Int) -> Bool {
        true
    }
}
