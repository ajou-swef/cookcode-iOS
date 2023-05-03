//
//  AccountSerivce.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//
import Alamofire
import Foundation

final class AccountService: AccountServiceProtocol {
    func check(_ nickname: String) async -> Result<AccountCheckResponse, ServiceError> {
        
        let url = "\(BASE_URL)/api/v1/account/check?nickname=\(nickname)"
        
        let response = await AF.request(url, method: .get).serializingDecodable(AccountCheckResponse.self).response
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func signUp(membershipForm: MembershipForm) async -> Result<SignUpResponse, ServiceError> {
        
        let url = "\(BASE_URL)/api/v1/account/signup"
        let param = [
            "email" : membershipForm.email,
            "nickname" : membershipForm.nickname,
            "password" : membershipForm.password
        ]
        
        let response = await AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).serializingDecodable(SignUpResponse.self).response
        
        print("\(response.debugDescription)")
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func signIn(_ signInForm: SignInForm) async -> Result<SignInResponse, ServiceError> {
        
        let url = "\(BASE_URL)/api/v1/account/signin"
        let param = [
            "email": signInForm.email,
            "password": signInForm.password
        ]
        
        let response = await AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).serializingDecodable(SignInResponse.self).response
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    }
    
    func getUserAccountByID(_ userID: Int) -> Result<UserAccountResponse, ServiceError> {
        .failure(ServiceError.MOCK())
    }
}
