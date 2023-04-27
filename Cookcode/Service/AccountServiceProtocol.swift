//
//  RecipeService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Foundation
import Alamofire

protocol AccountServiceProtocol {
    func check(_ nickname: String) -> Result<AccountCheckResponse, NetworkError>
    func signUp(membershipForm: MembershipForm) -> Result<SignUpResponse, NetworkError>
    func signIn(_ signInForm: SignInForm) -> Result<SignInResponse, NetworkError>
    func getUserAccountByID(_ userID: Int) -> Result<UserAccountResponse, NetworkError> 
}
