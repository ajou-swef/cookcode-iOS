//
//  AccountFailureService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/28.
//

import Alamofire
import Foundation
import cookcode_service

final class AccountServiceFailureStub: AccountServiceProtocol {
    func requestEmailCode(email: String) async -> Result<ServiceResponse<String>, ServiceError> {
        .failure(.mock())
    }
    
    func resetPassword(dto: PasswordFormDto) async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    func requestTemporaryPasswordByEmail(_ email: String) async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    func requestAuthority(_ authority: Authority) async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    func fetchMySubscriber() async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError> {
        .failure(.mock())
    }
    
    func updateProfile(_ profileForm: ProfileForm) async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    func fetchMyPublisher() async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError> {
        .failure(.mock())
    }
    
    func unsubscribeUserById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    func searchUser(query: String) async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError> {
        .failure(.mock())
    }
    
    func toggleUserSubscribeById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    func getUserDetailById(_ userId: Int) async -> Result<ServiceResponse<UserDetailDTO>, ServiceError> {
        .failure(.mock())
    }
    
    func signIn(_ signInForm: SignInForm) async -> Result<ServiceResponse<SignInDto>, ServiceError> {
        return .failure(.mock())
    }
    
    func deleteAccount() async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    func check(_ nickname: String) -> Result<ServiceResponse<AccountCheckDto>, ServiceError> {
        return .failure(.mock())
    }
    
    func signUp(membershipForm: MembershipForm) async -> Result<ServiceResponse<SignUpDto>, ServiceError> {
        .failure(.mock())
    }
    
    func getUserAccountByID(_ userID: Int) -> Result<ServiceResponse<UserAccountDto>, ServiceError> {
        .failure(.mock())
    }
}
