//
//  RefrigeratorServiceProtocol .swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Alamofire
import Foundation

protocol RefrigeratorServiceProtocol {
    func getMyIngredientCells() async -> Result<ServiceResponse<[IngredientCellDto]>, ServiceError> 
}

