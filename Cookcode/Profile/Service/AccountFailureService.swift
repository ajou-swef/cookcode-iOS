//
//  AccountFailureService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/28.
//

import Alamofire
import Foundation

final class AccountFailureService: AccountServiceProtocol {
    func unsubscribeUserById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func searchUser(query: String) async -> Result<ServiceResponse<PageResponse<UserCellDto>>, ServiceError> {
        .failure(.MOCK())
    }
    
    func subscribeUserById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func getUserDetailById(_ userId: Int) async -> Result<ServiceResponse<UserDetailDTO>, ServiceError> {
        .failure(.MOCK())
    }
    
    func signIn(_ signInForm: SignInForm) async -> Result<ServiceResponse<SignInDto>, ServiceError> {
        return .failure(ServiceError(message: "에러 메시지", status: 400))
    }
    
    func deleteAccount() async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func check(_ nickname: String) -> Result<ServiceResponse<AccountCheckDto>, ServiceError> {
        return .failure(.MOCK())
    }
    
    func signUp(membershipForm: MembershipForm) async -> Result<ServiceResponse<SignUpDto>, ServiceError> {
        return .failure(ServiceError(message: "에러 메시지", status: 400))
    }
    
    func getUserAccountByID(_ userID: Int) -> Result<ServiceResponse<UserAccountDto>, ServiceError> {
        return .failure(ServiceError(message: "에러 메시지", status: 400))
    }
}
