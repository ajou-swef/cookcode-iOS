//
//  AccountSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Foundation

final class AccountServiceSuccessStub: AccountServiceProtocol {
    func requestEmailCode(email: String) async -> Result<ServiceResponse<String>, ServiceError> {
        .success(.mock())
    }
    
    func resetPassword(dto: PasswordFormDto) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func requestTemporaryPasswordByEmail(_ email: String) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func requestAuthority(_ authority: Authority) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func fetchMySubscriber() async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError> {
        .success(.mock())
    }
    
    func updateProfile(_ profileForm: ProfileForm) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
 
    func fetchMyPublisher() async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError> {
        .success(.mock())
    }
    
    func unsubscribeUserById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func searchUser(query: String) async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError> {
        .success(.mock())
    }
    
    func toggleUserSubscribeById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func getUserDetailById(_ userId: Int) async -> Result<ServiceResponse<UserDetailDTO>, ServiceError> {
        .success(.mock())
    }
    
    func deleteAccount() async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func signIn(_ signInForm: SignInForm) async -> Result<ServiceResponse<SignInDto>, ServiceError> {
        .success(.mock())
    }
    
    func check(_ nickname: String) -> Result<ServiceResponse<AccountCheckDto>, ServiceError> {
        .success(.mock())
    }
    
    func signUp(membershipForm: MembershipForm) -> Result<ServiceResponse<SignUpDto>, ServiceError> {
        .success(.mock())
    }
    
    func getUserAccountByID(_ userID: Int) -> Result<ServiceResponse<UserAccountDto>, ServiceError> {
        .success(.mock())
    }
}
