//
//  RecipeService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Alamofire
import Foundation

protocol AccountServiceProtocol {
    func check(_ nickname: String) -> Result<AccountCheckResponse, ServiceError>
    func signUp(membershipForm: MembershipForm) -> Result<SignUpResponse, ServiceError>
    func signIn(_ signInForm: SignInForm) async -> Result<SignInResponse, ServiceError>
    func getUserAccountByID(_ userID: Int) -> Result<UserAccountResponse, ServiceError>
}
