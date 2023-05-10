//
//  RefrigeratorSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Foundation

final class RefrigeratorSuccessService: RefrigeratorServiceProtocol {
    func patchIngredient(dto: IngredientFormDTO, fridgeIngredId: Int) async -> Result<ServiceResponse<String>, ServiceError> {
        .success(.mock())
    }
    
    func postIngredient(dto: IngredientFormDTO) async -> Result<ServiceResponse<String>, ServiceError> {
        .success(.mock())
    }
    
    func getMyIngredientCells() async -> Result<ServiceResponse<IngredientDetailDTOs>, ServiceError> {
        .success(ServiceResponse.mock())
    }
}
