//
//  RefrigeratorViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/04.
//

import Foundation

class RefrigeratorViewModel: SelectIngredientViewModel {
    
    @Published var searchText: String = ""
    @Published var ingredientQuantity: String = ""
    @Published var date: Date = .now
    
    @Published var ingredientFormIsPresented: Bool = false
    @Published var selectIngredientViewIsPresented: Bool = false
    
    @Published private(set) var ingredientCell: [IngredientCell] = [] 
    
    private(set) var fridgeService: RefrigeratorServiceProtocol
    
    init (fridgeService: RefrigeratorServiceProtocol) {
        self.fridgeService = fridgeService
        
    }
    
    func fetchIngredients() async {
//        let result = fridgeService.getMyIngredientCells()
//        switch result {
//        case .success(let success):
//            success.data
//        case .failure(let failure):
//            <#code#>
//        }
    }
    
    func ingredientCellTapped(_ ingredientID: Int) {
        ingredientFormIsPresented = true 
    }
    
    func isNotSelected(_ ingredientID: Int) -> Bool {
        true
    }
    
    
}
