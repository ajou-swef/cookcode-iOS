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
    
    var emailIsEmpty: Bool {
        email.isEmpty
    }
    
    var passwordIsEmpty: Bool {
        password.isEmpty
    }
    var nicknameIsEmpty: Bool {
        nickname.isEmpty
    }
    
    var passwordIsEnoughLong: Bool {
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
    
    var passwordIsValid: Bool {
        passwordContainsNumber && passwordContainsAlphabet && passwordContainsSpecialCharacter && passwordIsEnoughLong
    }
}
