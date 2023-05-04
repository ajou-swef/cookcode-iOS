//
//  SelectIngredientViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/04.
//

import Foundation

class SelectIngredientViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published private(set) var selectedIngredientIDs: [IngredientCell] = []
    
    func ingredientCellTapped(_ ingredientCell: IngredientCell) {
        
        for i in selectedIngredientIDs.indices {
            if selectedIngredientIDs[i] == ingredientCell {
                selectedIngredientIDs.remove(at: i)
                return
            }
        }
        
        selectedIngredientIDs.append(ingredientCell)
    }
}
