//
//  RefrigeratorSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Foundation
import cookcode_service

final class FridgeSuccessStub: FridgeServiceProtocol {
    func deleteIngredient(fridgeIngredId: Int) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func patchIngredient(dto: IngredientFormDTO, fridgeIngredId: Int) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func postIngredient(dto: IngredientFormDTO) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func getMyIngredientCells() async -> Result<ServiceResponse<IngredientDetailDTOs>, ServiceError> {
        .success(ServiceResponse.mock())
    }
}
