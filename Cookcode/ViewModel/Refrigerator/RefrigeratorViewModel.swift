//
//  RefrigeratorViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/04.
//

import Foundation

class RefrigeratorViewModel: ObservableObject {

    
    @Published var ingredientFormIsPresented: Bool = false
    
    @Published var selectedIngredientDetail: IngredientDetail?
    @Published private(set) var refrigerator: [IngredientType: [IngredientDetail]] = [:]
    
    @Published var serviceAlert: ServiceAlert = .init()
    
    private(set) var fridgeService: RefrigeratorServiceProtocol
    
    init (fridgeService: RefrigeratorServiceProtocol) {
        self.fridgeService = fridgeService
        
        for type in IngredientType.allCases {
            refrigerator[type] = [] 
        }
        
        Task {
            await fetchIngredients()
        }
    }
    
    @MainActor
    func fetchIngredients() async {
        let result = await fridgeService.getMyIngredientCells()
        switch result {
        case .success(let success):
            let dtos = success.data.ingreds
            for dto in dtos {
                let type = IngredientType(rawValue: dto.category)
                let cell = IngredientDetail(dto: dto)
                
                if let type = type {
                    refrigerator[type]?.append(cell)
                }
            }
            
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    func ingredientCellTapped(_ cell: IngredientCell) {
        for (_, details) in refrigerator {
            for detail in details {
                if (String(detail.fridgeIngredId) == cell.id) {
                    selectedIngredientDetail = detail
                    return 
                }
            }
        }
    }
}
