//
//  RefrigeratorServiceProtocol .swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Alamofire
import Foundation

protocol FridgeServiceProtocol {
    func getMyIngredientCells() async -> Result<ServiceResponse<IngredientDetailDTOs>, ServiceError>
    func postIngredient(dto: IngredientFormDTO) async -> Result<DefaultResponse, ServiceError>
    func patchIngredient(dto: IngredientFormDTO, fridgeIngredId: Int) async -> Result<DefaultResponse, ServiceError>
    func deleteIngredient(fridgeIngredId: Int) async -> Result<DefaultResponse, ServiceError>
}

