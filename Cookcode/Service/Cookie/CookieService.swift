//
//  CookieService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/25.
//

import Alamofire
import Foundation

final class CookieService: CookieServiceProtocol {
    func deleteCommentById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        let url = "\(BASE_URL)/api/v1/cookie/comments/\(id)"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .delete, headers: headers)
            .serializingDecodable(DefaultResponse.self).response
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.decodeError()
        }
    }
    
    func postCommentWithId(_ comments: String, id: Int) async -> Result<DefaultResponse, ServiceError> {
        let url = "\(BASE_URL)/api/v1/cookie/\(id)/comments"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let parameter: [String: Any] = [
            "" : comments
        ]
        
        let response = await AF.request(url, method: .post, parameters: parameter,
                                        encoding: JSONEncoding.default, headers: headers)
            .serializingDecodable(DefaultResponse.self).response
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.decodeError()
        }
    }
    
    func fetchCommentsById(_ id: Int) async -> Result<ServiceResponse<[CommentDTO]>, ServiceError> {
        let url = "\(BASE_URL)/api/v1/cookie/\(id)/comments"
        
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .get, headers: headers)
            .serializingDecodable(ServiceResponse<[CommentDTO]>.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.decodeError()
        }
    }
    
    func getCookie() async -> Result<ServiceResponse<[CookieDetailDTO]>, ServiceError> {
        let url = "\(BASE_URL)/api/v1/cookie"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .get, headers: headers)
            .serializingDecodable(ServiceResponse<[CookieDetailDTO]>.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func postCookie(cookie: CookieForm) async -> Result<DefaultResponse, ServiceError> {
        
        let url = "\(BASE_URL)/api/v1/cookie"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.upload(multipartFormData: { multipart in
            guard let videoURL = cookie.videoURL else { return }
            multipart.append(videoURL, withName: "multipartFile",
                             fileName: UUID().uuidString, mimeType: "video/mp4")
            
            multipart.append(Data(cookie.title.utf8), withName: "title")
            multipart.append(Data(cookie.description.utf8), withName: "description")
        }, to: url, method: .post, headers: headers)
            .serializingDecodable(DefaultResponse.self).response
        
//        if response.error != nil {
            print("\(response.debugDescription)")
//        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
       
    }
}
