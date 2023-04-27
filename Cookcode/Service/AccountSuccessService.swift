//
//  AccountSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Foundation

final class AccountSuccessService: AccountServiceProtocol {
    func check(_ nickname: String) -> Result<AccountCheckResponse, NetworkError> {
        return .success(AccountCheckResponse(message: "중복 검사 성공", status: 200,
                                             data: AccountCheckResponse.MOCK_DATA_UNIQUE))
    }
    
    func signUp(membershipForm: MembershipForm) -> Result<SignUpResponse, NetworkError> {
        return .success(SignUpResponse(message: "회원가입 성공", status: 200,
                                       data: SignUpResponse.MOCK_DATA))
    }
    
    func signIn(_ signInForm: SignInForm) -> Result<SignInResponse, NetworkError> {
        return .success(SignInResponse(message: "로그인 성공", status: 200,
                                       data: SignInResponse.MOCK_DATA))
    }
    
    func getUserAccountByID(_ userID: Int) -> Result<UserAccountResponse, NetworkError> {
        return .success(UserAccountResponse(message: "정보 조회 성공", status: 200,
                                            data: UserAccountResponse.MOCK_DATA))
    }
}
