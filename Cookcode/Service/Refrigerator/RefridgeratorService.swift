//
//  RefridgeratorService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/08.
//

import Foundation
import Alamofire

final class RefridgeratorService: RefrigeratorServiceProtocol {
    func postIngredient(dto: IngredientFormDTO) async -> Result<ServiceResponse<String>, ServiceError> {
        let url = "\(BASE_URL)/api/v1/fridge/ingred"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let param: [String: Any] = [
            "ingredId" : dto.ingredId,
            "expiredAt" : dto.expiredAt,
            "quantity" : dto.quantity
        ]
        
        let response = await AF.request(url, method: .post, parameters: param,
                                        encoding: JSONEncoding.default, headers: headers)
            .serializingDecodable(ServiceResponse<String>.self).response
        
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func getMyIngredientCells() async -> Result<ServiceResponse<IngredientDetailDTOs>, ServiceError> {
        let url = "\(BASE_URL)/api/v1/fridge/"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? "" 
        ]
        

        let response = await AF.request(url, method: .get, headers: headers)
            .serializingDecodable(ServiceResponse<IngredientDetailDTOs>.self).response
        
        print("\(response.debugDescription)")
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
}
