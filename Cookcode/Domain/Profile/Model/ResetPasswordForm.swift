//
//  ResetPasswordForm.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import Foundation

struct ResetPasswordForm {
    var currentPassword: String = ""
    var newPassword: String = ""
    var passwordCheck: String = ""
    
    private var passwordMatch: Bool {
        newPassword == passwordCheck
    }
    
    private var passwordIsEnoughLong: Bool {
        newPassword.count >= 8
    }
    
    
    private var passwordContainsAlphabet: Bool {
        newPassword.contains {
            $0.isAlphabet
        }
    }
    
    private var passwordContainsSpecialCharacter: Bool {
        newPassword.contains {
            $0.isSpecialCharacter
        }
    }
    
    private var passwordContainsNumber: Bool {
        newPassword.contains {
            $0.isNumber
        }
    }
    
    var everyFieldIsFilled: Bool {
        !currentPassword.isEmpty && !newPassword.isEmpty && !passwordCheck.isEmpty
    }
    
    var passwordIsValid: Bool {
        passwordContainsNumber && passwordContainsAlphabet && passwordContainsSpecialCharacter && passwordIsEnoughLong
    }
}
