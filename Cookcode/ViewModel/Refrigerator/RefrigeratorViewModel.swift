//
//  RefrigeratorViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/04.
//

import Foundation

class RefrigeratorViewModel: ObservableObject {

    @Published var selectedIngredientDetail: IngredientDetail?
    @Published private(set) var refrigerator: [IngredientType: [IngredientDetail]] = [:]
    
    @Published var serviceAlert: ViewAlert = .init()
    @Published private(set) var presentedIngredientTypes: [IngredientType] = IngredientType.allCases
    
    
    
    private(set) var fridgeService: FridgeServiceProtocol
    
    init (fridgeService: FridgeServiceProtocol) {
        self.fridgeService = FridgeServiceInjector.select(service: fridgeService)
        for type in IngredientType.allCases {
            refrigerator[type] = []
        }
        
        
        Task { await fetchIngredients() }
    }
    
    @MainActor
    func fetchIngredients() async {
        let result = await fridgeService.getMyIngredientCells()
        
        var newRefridgerator: [IngredientType: [IngredientDetail]] = [:]
        for type in IngredientType.allCases {
            newRefridgerator[type] = []
        }
        
        switch result {
        case .success(let success):
            let dtos = success.data.ingreds
            for dto in dtos {
                let detail = IngredientDetail(dto: dto)
                let type = IngredientCell(detail: detail).ingredientType
                newRefridgerator[type]?.append(detail)
            }
            
            refrigerator = newRefridgerator
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
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
    
    func ingredientTypeButtonTapped(_ ingredientType: IngredientType) {
        let index = presentedIngredientTypes.firstIndex { $0 == ingredientType }
        
        guard let index = index else {
            presentedIngredientTypes.append(ingredientType)
            return
        }
        
        presentedIngredientTypes.remove(at: index)
    }
    
    func ingredientTypeisHidden(_ ingredientType: IngredientType) -> Bool {
        !presentedIngredientTypes.contains { $0 == ingredientType  }
    }
}
