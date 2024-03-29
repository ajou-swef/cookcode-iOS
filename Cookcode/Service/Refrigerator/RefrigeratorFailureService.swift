//
//  RefrigeratorFailureService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Foundation

final class FridgeFailureStub: FridgeServiceProtocol {
    func deleteIngredient(fridgeIngredId: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func patchIngredient(dto: IngredientFormDTO, fridgeIngredId: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func postIngredient(dto: IngredientFormDTO) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func getMyIngredientCells() async -> Result<ServiceResponse<IngredientDetailDTOs>, ServiceError> {
        .failure(.MOCK())
    }
}
