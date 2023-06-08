//
//  AccountSerivce.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//
import Alamofire
import Foundation

final class AccountService: AccountServiceProtocol {
    func fetchMySubscriber() async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError> {
        let url = "\(BASE_URL)/api/v1/account/subscribe/subscribers"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .get, headers: headers)
            .serializingDecodable(ServiceResponse<PageResponse<UserProfileCellDto>>.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? .decodeError()
        }
    }
    
    func updateProfile(_ profileForm: ProfileForm) async -> Result<DefaultResponse, ServiceError> {
        let url = "\(BASE_URL)/api/v1/account/profileImage"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        guard let imageData = profileForm.data else { return .failure(.MOCK()) }
        
        let response = await AF.upload(multipartFormData: { multipart in
            
            multipart.append("\(profileForm.thumbnail ?? "")".data(using: .utf8)!, withName: "oldProfileImage")
            multipart.append(imageData, withName: "profileImage", fileName: UUID().uuidString, mimeType: "video/mp4")
 
        }, to: url, method: .patch, headers: headers)
            .serializingDecodable(DefaultResponse.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func fetchMyPublisher() async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError> {
        let url = "\(BASE_URL)/api/v1/account/subscribe/publishers"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .get, headers: headers)
            .serializingDecodable(ServiceResponse<PageResponse<UserProfileCellDto>>.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? .decodeError()
        }
    }
    
    func searchUser(query: String) async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError> {
        let url = "\(BASE_URL)/api/v1/account/search?nickname=\(query)"
        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let encodedURL = URL(string: encoded)!
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(encodedURL, method: .get, headers: headers)
            .serializingDecodable(ServiceResponse<PageResponse<UserProfileCellDto>>.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? .decodeError()
        }
    }
    
    func toggleUserSubscribeById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        let url = "\(BASE_URL)/api/v1/account/subscribe/\(id)"
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
            return serviceErorr ?? .decodeError()
        }
    }
    
    func getUserDetailById(_ userId: Int) async -> Result<ServiceResponse<UserDetailDTO>, ServiceError> {
        let url = "\(BASE_URL)/api/v1/account/\(userId)"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .get, headers: headers).serializingDecodable(ServiceResponse<UserDetailDTO>.self).response
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? .decodeError()
        }
    }
    
    func signIn(_ signInForm: SignInForm) async -> Result<ServiceResponse<SignInDto>, ServiceError> {
        let url = "\(BASE_URL)/api/v1/account/signin"
        let param = [
            "email": signInForm.email,
            "password": signInForm.password
        ]
        
        let response = await AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).serializingDecodable(ServiceResponse<SignInDto>.self).response
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func check(_ nickname: String) async -> Result<ServiceResponse<AccountCheckDto>, ServiceError> {
        
        let url = "\(BASE_URL)/api/v1/account/check?nickname=\(nickname)"
        
        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let encodedURL = URL(string: encoded)!
        
        let response = await AF.request(encodedURL, method: .get).serializingDecodable(ServiceResponse<AccountCheckDto>.self).response
        
        if response.error != nil {
            print("\(response.debugDescription)")
        }
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func deleteAccount() async -> Result<DefaultResponse, ServiceError> {
        
        let url = "\(BASE_URL)/api/v1/account"
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        let response = await AF.request(url, method: .patch, headers: headers)
            .serializingDecodable(DefaultResponse.self).response
        
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func signUp(membershipForm: MembershipForm) async -> Result<ServiceResponse<SignUpDto>, ServiceError> {
        
        let url = "\(BASE_URL)/api/v1/account/signup"
        let param = [
            "email" : membershipForm.email,
            "nickname" : membershipForm.nickname,
            "password" : membershipForm.password
        ]
        
        let response = await AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).serializingDecodable(ServiceResponse<SignUpDto>.self).response
        
        print("\(response.debugDescription)")
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func getUserAccountByID(_ userID: Int) -> Result<ServiceResponse<UserAccountDto>, ServiceError> {
        .failure(ServiceError.MOCK())
    }
}
