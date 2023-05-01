//
//  RefrigeratorSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Foundation

final class RefrigeratorSuccessService: RefrigeratorServiceProtocol {
    func getMyIngredientCells() async -> Result<IngredientCellsResponse, ServiceError> {
        .success(.MOCK())
    }
}
