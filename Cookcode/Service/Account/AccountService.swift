//
//  AccountSerivce.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//
import Alamofire
import Foundation

final class AccountService: AccountServiceProtocol {
    func check(_ nickname: String) -> Result<AccountCheckResponse, ServiceError> {
        .failure(ServiceError.MOCK())
    }
    
    func signUp(membershipForm: MembershipForm) -> Result<SignUpResponse, ServiceError> {
        .failure(ServiceError.MOCK())
    }
    
    func signIn(_ signInForm: SignInForm) -> Result<SignInResponse, ServiceError> {
        
    }
    
    func getUserAccountByID(_ userID: Int) -> Result<UserAccountResponse, ServiceError> {
        .failure(ServiceError.MOCK())
    }
}
