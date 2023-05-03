//
//  AccountFailureService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/28.
//

import Alamofire
import Foundation

final class AccountFailureService: AccountServiceProtocol {
    func check(_ nickname: String) -> Result<AccountCheckResponse, ServiceError> {
        return .failure(ServiceError(message: "에러 메시지", status: 400))
    }
    
    func signUp(membershipForm: MembershipForm) -> Result<SignUpResponse, ServiceError> {
        return .failure(ServiceError(message: "에러 메시지", status: 400))
    }
    
    func signIn(_ signInForm: SignInForm) async -> Result<SignInResponse, ServiceError> {
        return .failure(ServiceError(message: "에러 메시지", status: 400))
    }
    
    func getUserAccountByID(_ userID: Int) -> Result<UserAccountResponse, ServiceError> {
        return .failure(ServiceError(message: "에러 메시지", status: 400))
    }
}
