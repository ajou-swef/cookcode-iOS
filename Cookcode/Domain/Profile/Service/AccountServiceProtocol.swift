//
//  RecipeService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Alamofire
import Foundation

protocol AccountServiceProtocol {
    func requestEmailCode(email: String) async -> Result<ServiceResponse<String>, ServiceError>
    
    func resetPassword(dto: PasswordFormDto) async -> Result<DefaultResponse, ServiceError> 
    
    func requestTemporaryPasswordByEmail(_ email: String) async -> Result<DefaultResponse, ServiceError> 
    
    func requestAuthority(_ authority: Authority) async -> Result<DefaultResponse, ServiceError> 
    
    func updateProfile(_ profileForm: ProfileForm) async -> Result<DefaultResponse, ServiceError>
    
    func fetchMyPublisher() async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError>
    func fetchMySubscriber() async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError> 
    
    func searchUser(query: String) async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError>
    
    func toggleUserSubscribeById(_ id: Int) async -> Result<DefaultResponse, ServiceError>
    
    func check(_ nickname: String) async -> Result<ServiceResponse<AccountCheckDto>, ServiceError>
    
    func deleteAccount() async -> Result<DefaultResponse, ServiceError> 
    
    func signUp(membershipForm: MembershipForm) async -> Result<ServiceResponse<SignUpDto>, ServiceError>
    
    func signIn(_ signInForm: SignInForm) async -> Result<ServiceResponse<SignInDto>, ServiceError>
    
    func getUserDetailById(_ userId: Int) async -> Result<ServiceResponse<UserDetailDTO>, ServiceError>
}
