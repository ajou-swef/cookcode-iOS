//
//  RecipeService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/10.
//

import Alamofire
import Foundation

final class RecipeService: RecipeServiceProtocol {
    func likesContentById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        let url = "\(BASE_URL)/api/v1/recipe/\(id)/likes"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .post, headers: headers)
            .serializingDecodable(DefaultResponse.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func fetchRecipeCellsByUserId(_ id: Int) async -> Result<ServiceResponse<PageResponse<RecipeCellDto>>, ServiceError> {
        let url = "\(BASE_URL)/api/v1/recipe/user/\(id)"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .get, headers: headers)
            .serializingDecodable(ServiceResponse<PageResponse<RecipeCellDto>>.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func searchRecipeCells(query: String, coockable: Bool, page: Int, size: Int, sort: String?) async -> Result<ServiceResponse<PageResponse<RecipeCellDto>>, ServiceError> {
        let cookableValue = coockable ? 1 : 0
        var url = "\(BASE_URL)/api/v1/recipe/search?query=\(query)&cookable=\(cookableValue)&page=\(page)&size=\(size)"
        
        if let sort = sort {
            url.append("&sort=\(sort)")
        }
        
        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let encodedURL = URL(string: encoded)!
        
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(encodedURL, method: .get, headers: headers)
            .serializingDecodable(ServiceResponse<PageResponse<RecipeCellDto>>.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }

        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    
    func deleteCommentById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        let url = "\(BASE_URL)/api/v1/recipe/comments/\(id)"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .delete, headers: headers)
            .serializingDecodable(DefaultResponse.self).response
        
        print("\(response.debugDescription)")
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.decodeError()
        }
    }
    
    func deleteRecipe(recipeId: Int) async -> Result<DefaultResponse, ServiceError> {
        let url = "\(BASE_URL)/api/v1/recipe/\(recipeId)"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        
        let response = await AF.request(url, method: .delete, headers: headers).serializingDecodable(DefaultResponse.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func patchRecipe(formDTO: RecipeFormDTO, recipeId: Int) async -> Result<DefaultResponse, ServiceError> {
        let url = "\(BASE_URL)/api/v1/recipe/\(recipeId)"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .patch, parameters: formDTO, encoder: JSONParameterEncoder.default, headers: headers).serializingDecodable(DefaultResponse.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func fetchRecipeCells(page: Int, size: Int, search: SearchMembershipType, sort: String?, month: Int?, cookcable: Bool?) async -> Result<ServiceResponse<PageResponse<RecipeCellDto>>, ServiceError> {
        
        
        var url = "\(BASE_URL)/api/v1/recipe\(search.pathVariable)?page=\(page)&size=\(size)"
        
        if let sort = sort {
            url.append("&sort=\(sort)")
        }
        
        if let cookcable = cookcable {
            let value: Int = cookcable ? 1 : 0
            url.append("&cookable=\(value)")
        }
        
        
        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let encodedURL = URL(string: encoded)!
        
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(encodedURL, method: .get, headers: headers)
            .serializingDecodable(ServiceResponse<PageResponse<RecipeCellDto>>.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func searchRecipe(_ recipeID: Int) async -> Result<ServiceResponse<RecipeDetailDTO>, ServiceError> {
        let url = "\(BASE_URL)/api/v1/recipe/\(recipeID)"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        
        let response = await AF.request(url, method: .get, headers: headers)
            .serializingDecodable(ServiceResponse<RecipeDetailDTO>.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func postRecipe(_ form: RecipeFormDTO) async -> Result<ServiceResponse<PostRecipeResonse>, ServiceError> {
        
        let url = "\(BASE_URL)/api/v1/recipe"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .post, parameters: form, encoder: JSONParameterEncoder.default, headers: headers).serializingDecodable(ServiceResponse<PostRecipeResonse>.self).response
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
}

extension RecipeService: CommentServiceProtocol {
    func postCommentWithId(_ comments: String, id: Int) async -> Result<DefaultResponse, ServiceError> {
        
        let url = "\(BASE_URL)/api/v1/recipe/\(id)/comments"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let parameter: [String: Any] = [
            "comment" : comments
        ]
        
        let response = await AF.request(url, method: .post, parameters: parameter,
                                        encoding: JSONEncoding.default, headers: headers)
            .serializingDecodable(DefaultResponse.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.decodeError()
        }
    }
    
    func fetchCommentsById(_ id: Int) async -> Result<ServiceResponse<PageResponse<CommentDTO>>, ServiceError> {
        let url = "\(BASE_URL)/api/v1/recipe/\(id)/comments"
        
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .get, headers: headers)
            .serializingDecodable(ServiceResponse<PageResponse<CommentDTO>>.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.decodeError()
        }
    }
}
