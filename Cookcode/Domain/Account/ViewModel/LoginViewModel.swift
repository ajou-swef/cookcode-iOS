//
//  LoginViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/03/05.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    let accountService: AccountServiceProtocol
    @Published var signInForm: SignInForm = .init()
    @Published var serviceAlert: ViewAlert = .init()
    
    init (accountService: AccountServiceProtocol) {
        self.accountService = AccountServiceInjector.select(service: accountService)
    }
    
    @MainActor
    func signIn() async -> Bool {
        let result = await accountService.signIn(signInForm)
        
        switch result {
        case .success(let success):
            UserDefaults.standard.set(success.data.accessToken, forKey: ACCESS_TOKEN_KEY)
            UserDefaults.standard.set(success.data.refreshToken, forKey: REFRESH_TOKEN_KEY)
            UserDefaults.standard.set(success.data.userID, forKey: USER_ID)
            return true
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
            return false
        }
    }
    
    @MainActor
    func clear() {
        signInForm.clear()
    }
}
