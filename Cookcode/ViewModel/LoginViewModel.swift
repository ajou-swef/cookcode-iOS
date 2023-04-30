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
    @Published var serviceAlert: ServiceAlert = .init()
    
    init (accountService: AccountServiceProtocol) {
        self.accountService = accountService
    }
    
    func signIn() {
        let result = accountService.signIn(signInForm)
        
        switch result {
        case .success(_):
            print("로그인 성공 ")
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
}
