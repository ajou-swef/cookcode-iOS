//
//  AdminService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/12.
//

import Alamofire
import Foundation
import cookcode_service

final class AdminService {
    func treatAuthRequest(userId: Int, isAccepted: Bool) async -> Result<DefaultResponse, ServiceError> {
        let url = "\(BASE_URL)/api/v1/admin/authorization/\(userId)/\(isAccepted)"
        
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .get, headers: headers)
            .serializingDecodable(DefaultResponse.self).response
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? .decodeError()
        }
    }
    
    func fetchAuthRequest() async -> Result<ServiceResponse<[UserAutoDto]>, ServiceError> {
        let url = "\(BASE_URL)/api/v1/admin/authorization"
        
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .get, headers: headers)
            .serializingDecodable(ServiceResponse<[UserAutoDto]>.self).response
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? .decodeError()
        }
    }
}
