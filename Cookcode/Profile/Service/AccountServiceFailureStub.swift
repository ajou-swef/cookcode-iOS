//
//  AccountFailureService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/28.
//

import Alamofire
import Foundation

final class AccountServiceFailureStub: AccountServiceProtocol {
    func requestEmailCode(email: String) async -> Result<ServiceResponse<String>, ServiceError> {
        .failure(.MOCK())
    }
    
    func resetPassword(dto: PasswordFormDto) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func requestTemporaryPasswordByEmail(_ email: String) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func requestAuthority(_ authority: Authority) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func fetchMySubscriber() async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError> {
        .failure(.MOCK())
    }
    
    func updateProfile(_ profileForm: ProfileForm) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func fetchMyPublisher() async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError> {
        .failure(.MOCK())
    }
    
    func unsubscribeUserById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func searchUser(query: String) async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError> {
        .failure(.MOCK())
    }
    
    func toggleUserSubscribeById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
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
