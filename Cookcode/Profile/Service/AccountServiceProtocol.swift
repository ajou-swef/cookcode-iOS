//
//  RecipeService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Alamofire
import Foundation

protocol AccountServiceProtocol {
    func updateProfile(_ profileForm: ProfileForm) async -> Result<DefaultResponse, ServiceError>
    
    func fetchMyPublisher() async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError> 
    
    func searchUser(query: String) async -> Result<ServiceResponse<PageResponse<UserProfileCellDto>>, ServiceError>
    
    func subscribeUserById(_ id: Int) async -> Result<DefaultResponse, ServiceError>
    func unsubscribeUserById(_ id: Int) async -> Result<DefaultResponse, ServiceError> 
    
    func check(_ nickname: String) async -> Result<ServiceResponse<AccountCheckDto>, ServiceError>
    
    func deleteAccount() async -> Result<DefaultResponse, ServiceError> 
    
    func signUp(membershipForm: MembershipForm) async -> Result<ServiceResponse<SignUpDto>, ServiceError>
    
    func signIn(_ signInForm: SignInForm) async -> Result<ServiceResponse<SignInDto>, ServiceError>
    
    func getUserDetailById(_ userId: Int) async -> Result<ServiceResponse<UserDetailDTO>, ServiceError>
}
