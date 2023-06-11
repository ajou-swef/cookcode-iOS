//
//  LoginForm.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/17.
//

import Foundation

struct SignInForm: Encodable {
    private var _email: String = ""
    private var _password: String = ""
    
    var email: String {
        get { _email }
        set(newValue) { _email = newValue }
    }
    
    var password: String {
        get { _password }
        set(newValue) { _password = newValue }
    }
    
    mutating func clear() {
        email = ""
        password = "" 
    }
}
