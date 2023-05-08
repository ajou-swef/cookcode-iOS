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
    @Published private(set) var refrigerator: [IngredientType: [IngredientCell]] = [:]
    
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
            let dtos = success.data
            for dto in dtos {
                let type = IngredientType(rawValue: dto.category)
                let cell = IngredientCell(dto: dto)
                if let type = type {
                    refrigerator[type]?.append(cell)
                } else {
                    print("타입 변환 에러")
                }
            }
            
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }   
}
