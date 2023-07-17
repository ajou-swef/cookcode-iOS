//
//  RefrigeratorFailureService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Foundation
import cookcode_service

final class FridgeFailureStub: FridgeServiceProtocol {
    func deleteIngredient(fridgeIngredId: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    func patchIngredient(dto: IngredientFormDTO, fridgeIngredId: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    func postIngredient(dto: IngredientFormDTO) async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    func getMyIngredientCells() async -> Result<ServiceResponse<IngredientDetailDTOs>, ServiceError> {
        .failure(.mock())
    }
}
