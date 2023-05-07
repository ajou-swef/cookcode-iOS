//
//  RefrigeratorViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/04.
//

import Foundation

class RefrigeratorViewModel: ObservableObject {

    
    @Published var ingredientFormIsPresented: Bool = false
    @Published var selectedIngredientId: IngredientCell?
    
    @Published private(set) var ingredientCell: [IngredientCell] = []
    @Published var serviceAlert: ServiceAlert = .init()
    
    private(set) var fridgeService: RefrigeratorServiceProtocol
    
    init (fridgeService: RefrigeratorServiceProtocol) {
        self.fridgeService = fridgeService
        
        Task {
            await fetchIngredients()
        }
    }
    
    @MainActor
    func fetchIngredients() async {
        let result = await fridgeService.getMyIngredientCells()
        switch result {
        case .success(let success):
            ingredientCell = success.data.map { IngredientCell(dto: $0) }
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }   
}
