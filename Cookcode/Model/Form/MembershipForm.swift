//
//  MembershipForm.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/17.
//

import Foundation

struct MembershipForm {
    var email: String = ""
    var nickname: String = ""
    var password: String = ""
    var passwordCheck: String = ""
    
    var passwordMatch: Bool {
        password == passwordCheck
    }
    
    var isEmptyEmail: Bool {
        email.isEmpty
    }
    
    var isEmptyPassword: Bool {
        password.isEmpty
    }
    var isNicknaemEmpty: Bool {
        nickname.isEmpty
    }
    
    var isEnoughLongPassword: Bool {
        password.count >= 8
    }
    
    
    var passwordContainsAlphabet: Bool {
        password.contains {
            $0.isAlphabet
        }
    }
    
    var passwordContainsSpecialCharacter: Bool {
        password.contains {
            $0.isSpecialCharacter
        }
    }
    
    var passwordContainsNumber: Bool {
        password.contains {
            $0.isNumber
        }
    }
    
    var isValidPassword: Bool {
        passwordContainsNumber && passwordContainsAlphabet && passwordContainsSpecialCharacter && isEnoughLongPassword
    }
}
