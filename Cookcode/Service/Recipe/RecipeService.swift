//
//  RecipeService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/10.
//

import Alamofire
import Foundation

final class RecipeServie: RecipeServiceProtocol {
    func searchRecipeHomeCell(page: Int, size: Int, sort: String, month: Int, cookcable: Bool) -> Result<RecipeCellSeachResponse, ServiceError> {
        .success(.MOCK_DATA)
    }
    
    func searchRecipe(_ recipeID: Int) -> Result<RecipeCellDto, ServiceError> {
        .success(.MOCK_DATA)
    }
    
    func postRecipe(_ form: RecipeFormDTO) async -> Result<ServiceResponse<String>, ServiceError> {
        
        let url = "\(BASE_URL)/api/v1/recipe"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .post, parameters: form, encoder: JSONParameterEncoder.default, headers: headers).serializingDecodable(ServiceResponse<String>.self).response
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func searchCell(page: Int, size: Int, sort: String, month: Int) async -> Result<[any SearchedCell], ServiceError> {
        .failure(.MOCK())
    }
}
