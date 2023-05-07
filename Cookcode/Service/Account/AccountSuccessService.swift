//
//  AccountSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Foundation

final class AccountSuccessService: AccountServiceProtocol {
    func signIn(_ signInForm: SignInForm) async -> Result<ServiceResponse<SignInDto>, ServiceError> {
        .success(.mock())
    }
    
    func check(_ nickname: String) -> Result<AccountCheckResponse, ServiceError> {
        return .success(AccountCheckResponse(message: "중복 검사 성공", status: 200,
                                             data: AccountCheckResponse.MOCK_DATA))
    }
    
    func signUp(membershipForm: MembershipForm) -> Result<ServiceResponse<SignUpDto>, ServiceError> {
        .success(.mock())
    }
    
    func getUserAccountByID(_ userID: Int) -> Result<ServiceResponse<UserAccountDto>, ServiceError> {
        .success(.mock())
    }
}
