//
//  AccountSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Foundation

final class AccountSuccessService: AccountServiceProtocol {
    func check(_ nickname: String) -> Result<AccountCheckResponse, ServiceError> {
        return .success(AccountCheckResponse(message: "중복 검사 성공", status: 200,
                                             data: AccountCheckResponse.MOCK_DATA))
    }
    
    func signUp(membershipForm: MembershipForm) -> Result<SignUpResponse, ServiceError> {
        return .success(SignUpResponse(message: "회원가입 성공", status: 200,
                                       data: SignUpResponse.MOCK_DATA))
    }
    
    func signIn(_ signInForm: SignInForm) -> Result<SignInResponse, ServiceError> {
        return .success(SignInResponse(message: "로그인 성공", status: 200,
                                       data: SignInResponse.MOCK()))
    }
    
    func getUserAccountByID(_ userID: Int) -> Result<UserAccountResponse, ServiceError> {
        return .success(UserAccountResponse(message: "정보 조회 성공", status: 200,
                                            data: UserAccountResponse.MOCK_DATA))
    }
}
