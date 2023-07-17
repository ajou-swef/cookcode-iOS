//
//  RefridgeratorService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/08.
//

import Alamofire
import cookcode_service
import Foundation

final class RefridgeratorService: FridgeServiceProtocol {
    func deleteIngredient(fridgeIngredId: Int) async -> Result<DefaultResponse, ServiceError> {
        
        let url = "\(BASE_URL)/api/v1/fridge/ingred/\(fridgeIngredId)"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .delete,
                                        encoding: JSONEncoding.default, headers: headers)
            .serializingDecodable(DefaultResponse.self).response
        
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.mock()
        }
    }
    
    func patchIngredient(dto: IngredientFormDTO, fridgeIngredId: Int) async -> Result<DefaultResponse, ServiceError> {
        
        let url = "\(BASE_URL)/api/v1/fridge/ingred/\(fridgeIngredId)"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .patch, parameters: dto,
                                        encoder: JSONParameterEncoder.default, headers: headers)
            .serializingDecodable(DefaultResponse.self).response
        
        print("\(response.debugDescription)")
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.mock()
        }
    }
    
    func postIngredient(dto: IngredientFormDTO) async -> Result<DefaultResponse, ServiceError> {
        let url = "\(BASE_URL)/api/v1/fridge/ingred"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .post, parameters: dto,
                                        encoder: JSONParameterEncoder.default, headers: headers)
            .serializingDecodable(DefaultResponse.self).response
        
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.mock()
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
            return serviceErorr ?? ServiceError.mock()
        }
    }
}
