//
//  LoginViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/03/05.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var isShowingInefficientInputMessage: Bool = false
    
    @Published var idText: String = ""
    @Published var passwordText: String = ""
    
    func loginButtonTapped() {
        guard !idText.isEmpty && !passwordText.isEmpty else {
            isShowingInefficientInputMessage = true
            return
        }
        
        isShowingInefficientInputMessage = false
    }
    
    func login() {
        
    }
}
